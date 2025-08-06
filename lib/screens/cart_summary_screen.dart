
import 'package:e_market/screens/process_to_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartSummaryScreen extends StatefulWidget {
  const CartSummaryScreen({super.key});

  @override
  State<CartSummaryScreen> createState() => _CartSummaryScreenState();
}

class _CartSummaryScreenState extends State<CartSummaryScreen> {
  // Example shipping options; replace with real data / API later
  final List<Map<String, dynamic>> shippingOptions = [
    {'name': 'Standard Shipping ', 'cost': 50.0},
    {'name': 'Express Shipping', 'cost': 120.0},
    {'name': 'Next-Day Delivery', 'cost': 200.0},
  ];

  String? selectedShipping;

  @override
  void initState() {
    super.initState();
    selectedShipping = shippingOptions.first['name'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set default shipping cost in provider
      final provider = Provider.of<CartProvider>(context, listen: false);
      provider.setShippingCost(shippingOptions.first['cost']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final cartKeys = cartProvider.items.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Summary")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final productId = cartKeys[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: item.product.imageUrl != null
                              ? Image.network(
                                  'http://localhost:8080${item.product.imageUrl}',
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image),
                          title: Text(item.product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: ৳${item.product.price.toStringAsFixed(2)}"),
                              Text("Discount: ${item.product.discount}%"),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      cartProvider.decrementQuantity(productId);
                                    },
                                  ),
                                  Text("${item.quantity}"),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      cartProvider.incrementQuantity(productId);
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                "Total: ৳${item.totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartProvider.removeFromCart(productId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Shipping Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Text("Shipping Method: "),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedShipping,
                        items: shippingOptions
                            .map((option) => DropdownMenuItem<String>(
                                  value: option['name'],
                                  child: Text("${option['name']} (৳${option['cost']})"),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedShipping = value;
                            final selectedOption = shippingOptions.firstWhere((option) => option['name'] == value);
                            cartProvider.setShippingCost(selectedOption['cost']);
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Price summary
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      summaryRow("Subtotal:", cartProvider.subtotal),
                      summaryRow("VAT (15%):", cartProvider.vat),
                      summaryRow("Shipping Cost:", cartProvider.shippingCost),
                      const Divider(thickness: 1),
                      summaryRow("Grand Total:", cartProvider.grandTotal, isBold: true),
                    ],
                  ),
                ),

                // Checkout Button
                // Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: ElevatedButton.icon(
                //       onPressed: () {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(content: Text("Proceeding to checkout...")),
                //         );
                //       },
                //       icon: const Icon(Icons.shopping_cart_checkout),
                //       label: const Text("Checkout"),
                //     ),
                //   ),
                // ),
                Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProcessToCheckoutScreen(grandTotal: cartProvider.grandTotal),
          ),
        );
      },
      icon: const Icon(Icons.shopping_cart_checkout),
      label: const Text("Checkout"),
    ),
  ),
),

              ],
            ),
    );
  }

  Widget summaryRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text("৳ ${value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
