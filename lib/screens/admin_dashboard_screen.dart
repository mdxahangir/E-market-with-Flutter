import 'package:e_market/screens/manage_products_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class AdminDashboardScreen extends StatelessWidget {
  final UserResponse user;

  const AdminDashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> dashboardItems = [
      _DashboardItem("Total Users", Icons.people, "1,200"),
      _DashboardItem("Orders", Icons.shopping_cart, "580"),
      _DashboardItem("Revenue", Icons.attach_money, "\$95K"),
      _DashboardItem("Suppliers", Icons.store, "45"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard - ${user.fullName}"),
        backgroundColor: Colors.teal,
      ),

      // ✅ Sidebar Navigation (Navbar)
      drawer: Drawer(
        backgroundColor: Colors.teal.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.fullName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(user.fullName[0], style: const TextStyle(fontSize: 24)),
              ),
              decoration: const BoxDecoration(color: Colors.teal),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Manage Users"),
              onTap: () {
                // TODO: Add navigation
              },
            ),

            // ✅ Manage Products with submenu
            ExpansionTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text("Manage Products"),
              children: [
                ListTile(
                  title: const Text("Add Category"),
                  onTap: () => Navigator.pushNamed(context, '/add-category'),
                ),
                ListTile(
                  title: const Text("Add Subcategory"),
                  onTap: () => Navigator.pushNamed(context, '/add-subcategory'),
                ),
                ListTile(
                  title: const Text("Add Product"),
                  onTap: () => Navigator.pushNamed(context, '/add-product'),
                ),
                ListTile(
                  title: const Text("Product List"),
                  onTap: () => Navigator.pushNamed(context, '/product-list'),
                ),
              ],
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Manage Orders"),
              onTap: () {
                // TODO: Add navigation
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),


      // ✅ Dashboard Content
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 3,
        ),
        itemCount: dashboardItems.length,
        itemBuilder: (context, index) {
          final item = dashboardItems[index];
          return Card(
            elevation: 3,
            color: Colors.teal.shade50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(item.icon, color: Colors.white),
              ),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.value),
            ),
          );
        },
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final String value;

  _DashboardItem(this.title, this.icon, this.value);
}
