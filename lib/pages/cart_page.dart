import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Cart")
      ),
      drawer: const NavBar(),
      body: const Center(child: Text('Cart page')),
    );
  }
}
