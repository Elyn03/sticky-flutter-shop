import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/models/order.dart';
import 'package:sticky_flutter_shop/services/api_orders.dart';
import '../widgets/app_bar.dart';
import '../widgets/drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = ApiOrders.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders history'),
      drawer: const NavBar(),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order #${order.id}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "${order.items.length} items",
                              style: const TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Date: ${order.date.toLocal()}",
                              style: const TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${order.total.toStringAsFixed(2)}€",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Order #${order.id} Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: order.items.map((item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${item.quantity} x ${item.title}"),
                Text("\$${(item.quantity * item.price).toStringAsFixed(2)}"),
              ],
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
