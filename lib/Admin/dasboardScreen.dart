import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: _buildDrawer(context), // Drawer for navigation
      body: Center(
        child: const Text('Home Screen'),
      ),
    );
  }

  // Drawer Widget for Admin Navigation
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text('User', style: TextStyle(color: Colors.white, fontSize: 18)),
                Text('user@example.com', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          _createDrawerItem(icon: Icons.dashboard, text: 'Dashboard'),
          _createDrawerItem(icon: Icons.supervised_user_circle, text: 'Manage Users'),
          _createDrawerItem(icon: Icons.category, text: 'Manage Categories'),
          _createDrawerItem(icon: Icons.shopping_cart, text: 'Manage Products'),
          _createDrawerItem(icon: Icons.store, text: 'Manage Stores'),
          _createDrawerItem(icon: Icons.bar_chart, text: 'Sales Reports'),
        ],
      ),
    );
  }

  // Helper method to create a ListTile for Drawer without onTap
  Widget _createDrawerItem({IconData? icon, String? text}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text ?? ''),
    );
  }
}
