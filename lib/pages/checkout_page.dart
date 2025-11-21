import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/services/api_cart.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
import '../models/order.dart';
import '../services/api_orders.dart';
import '../widgets/button.dart';
import '../widgets/drawer.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardDateController = TextEditingController();
  final _cardCvcController = TextEditingController();
  final _cardNameController = TextEditingController();

  String errorMessage = "";
  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool _isCardNumberValid(String number) {
    final regex = RegExp(r'^\d{16}$');
    return regex.hasMatch(number.replaceAll(' ', ''));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cardNumberController.dispose();
    _cardDateController.dispose();
    _cardCvcController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  Future<void> _checkout(BuildContext context, CartProvider cart) async {
    if (!_isEmailValid(_emailController.text.trim())) {
      setState(() => errorMessage = "Invalid email address");
      return;
    }
    if (!_isCardNumberValid(_cardNumberController.text.trim())) {
      setState(() => errorMessage = "Invalid card number");
      return;
    }

    if (_emailController.text.trim().isEmpty ||
        _cardNumberController.text.trim().isEmpty ||
        _cardDateController.text.trim().isEmpty ||
        _cardCvcController.text.trim().isEmpty ||
        _cardNameController.text.trim().isEmpty
    ) {
      setState(() {
        errorMessage = "Please fill in all fields";
      });
      return;
    }

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      total: cart.totalPrice,
      items: cart.items.values
          .map((item) => OrderItem(
        title: item.title,
        quantity: item.quantity,
        price: item.price,
      )).toList(),
    );

    await ApiOrders.createOrder(order);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successful pay !'),
        backgroundColor: Colors.green,
      ),
    );
    context.pop();
    _emailController.clear();
    _cardNameController.clear();
    _cardNumberController.clear();
    _cardDateController.clear();
    _cardCvcController.clear();
    cart.clear();
  }

    @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Checkout", backButtonLink: "/cart"),
      drawer: const NavBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shipping information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Payment details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _cardNameController,
                        decoration: InputDecoration(
                          hintText: "Name on card",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          hintText: "1234 1234 1234 1234",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _cardDateController,
                              decoration: InputDecoration(
                                hintText: "MM / YY",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _cardCvcController,
                              decoration: InputDecoration(
                                hintText: "CVC",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (errorMessage.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red[700]),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      const SizedBox(height: 24),
                      Button(
                        text: "Pay now",
                        onPressed: () { _checkout(context, cart); },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Container(
                width: 1.3,
                height: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items.values.toList()[index];
                          return Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${item.quantity} × ${item.price.toStringAsFixed(2)}€",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${(item.price * item.quantity).toStringAsFixed(2)}€",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${cart.totalPrice.toStringAsFixed(2)}€",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
