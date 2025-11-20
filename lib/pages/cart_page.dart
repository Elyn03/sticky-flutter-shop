import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/services/api_cart.dart';
import '../widgets/app_bar.dart';
import '../widgets/drawer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart Page'),
      drawer: const NavBar(),
      body: cart.items.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items.values.toList()[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('Quantité: ${item.quantity}'),
                  trailing: Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                  leading: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => cart.removeItem(item.id),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: cart.clear,
            child: const Text('Vider le panier'),
          ),
        ],
      ),
    );
  }
}
