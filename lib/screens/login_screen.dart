import 'package:e_market/screens/admin_dashboard_screen.dart';
import 'package:e_market/screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // void handleLogin() async {
  //   final user = await ApiService.login(emailController.text, passwordController.text);

  //   if (user != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome ${user.fullName}')));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
  //   }
  // }
  void handleLogin() async {
  final user = await ApiService.login(emailController.text, passwordController.text);

  if (user != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Welcome ${user.fullName}')),
    );

    if (user.role == "ADMIN") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AdminDashboardScreen(user: user)),
      );
    } else {
      // You can redirect to Buyer/Supplier dashboard instead if needed
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Unauthorized'),
          content: Text('Access denied. Only admins can access this dashboard.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextFormField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: handleLogin, child: Text('Login')),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
              child: Text("Don't have an account? Register"),
            )
          ],
        ),
      ),
    );
  }
}
