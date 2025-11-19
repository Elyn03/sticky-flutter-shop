import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pop(context); // close the drawer
    context.go(route);      // navigate with go_router
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightGreen),
            child: Text("Menu"),
          ),

          ListTile(
            leading: const Icon(Icons.home, color: Colors.orange),
            title: const Text('Home'),
            onTap: () => _go(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.orange),
            title: const Text('Catalog'),
            onTap: () => _go(context, '/catalog'),
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart, color: Colors.green),
            title: const Text('Cart'),
            onTap: () => _go(context, '/cart'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.blue),
            title: const Text('Orders'),
            onTap: () => _go(context, '/orders'),
          ),
          ListTile(
            leading: const Icon(Icons.login, color: Colors.green),
            title: const Text('Login'),
            onTap: () => _go(context, '/login'),
          ),
          ListTile(
            leading: const Icon(Icons.check, color: Colors.green),
            title: const Text('Checkout'),
            onTap: () => _go(context, '/checkout'),
          ),
        ],
      ),
    );
  }
}
