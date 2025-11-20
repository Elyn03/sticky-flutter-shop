import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
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
      appBar: CustomAppBar(title: 'Cart Page'),
      drawer: const NavBar(),
      body: const Center(child: Text('Cart page')),
    );
  }
}
