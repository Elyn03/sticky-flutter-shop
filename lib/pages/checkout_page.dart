import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
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
      appBar: CustomAppBar(title: 'Checkout Page'),
      drawer: const NavBar(),
      body: const Center(child: Text('THE Checkout')),
    );
  }
}
