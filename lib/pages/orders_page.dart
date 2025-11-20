import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
import '../widgets/drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders Page'),
      drawer: const NavBar(),
      body: const Center(child: Text('Orders')),
    );
  }
}

