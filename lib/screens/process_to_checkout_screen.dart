import 'package:flutter/material.dart';

class ProcessToCheckoutScreen extends StatefulWidget {
  final double grandTotal;

  const ProcessToCheckoutScreen({super.key, required this.grandTotal});

  @override
  State<ProcessToCheckoutScreen> createState() => _ProcessToCheckoutScreenState();
}

class _ProcessToCheckoutScreenState extends State<ProcessToCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  // Address fields
  String fullName = '';
  String phoneNumber = '';
  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  String stateOrProvince = '';
  String postalCode = '';
  String country = '';
  String addressType = 'SHIPPING';

  // Payment
  String selectedPaymentMethod = 'CASH';
  final List<String> paymentMethods = ['CASH', 'CARD', 'BANK_TRANSFER', 'ONLINE'];

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // 🟩 এখানে API কল করবে Spring Boot backend-এ Address ও Payment save করার জন্য
      print('Grand Total: ৳${widget.grandTotal}');
      print('Name: $fullName');
      print('Payment Method: $selectedPaymentMethod');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Process to Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Grand Total: ৳${widget.grandTotal.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),
            const Text("Shipping Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Full Name"),
                    onSaved: (value) => fullName = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Phone Number"),
                    onSaved: (value) => phoneNumber = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Address Line 1"),
                    onSaved: (value) => addressLine1 = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Address Line 2"),
                    onSaved: (value) => addressLine2 = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "City"),
                    onSaved: (value) => city = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "State/Province"),
                    onSaved: (value) => stateOrProvince = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Postal Code"),
                    onSaved: (value) => postalCode = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Country"),
                    onSaved: (value) => country = value!,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: addressType,
                    items: ['SHIPPING', 'BILLING']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) => setState(() => addressType = value!),
                    decoration: const InputDecoration(labelText: "Address Type"),
                  ),

                  const SizedBox(height: 20),
                  const Text("Select Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedPaymentMethod,
                    items: paymentMethods
                        .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                    decoration: const InputDecoration(labelText: "Payment Method"),
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _submitOrder,
                    icon: const Icon(Icons.done_all),
                    label: const Text("Submit Order"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
