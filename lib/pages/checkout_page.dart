import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Checkout")
      ),
      drawer: const NavBar(),
      body: const Center(child: Text('THE Checkout')),
    );
  }
}
