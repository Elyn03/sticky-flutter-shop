import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/services/api_cart.dart';
import 'package:sticky_flutter_shop/services/api_mock.dart';
import 'package:sticky_flutter_shop/models/product.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductPage extends StatelessWidget {
  final int productId;

  const ProductPage({super.key, required this.productId});

  Future<void> _addToCart(BuildContext context, Product product) async {
    Provider.of<CartProvider>(context, listen: false).addItem(product.id, product.title, product.price);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.title} added!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: ApiMock.fetchProduct(productId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final product = snapshot.data!;

        if (!kIsWeb && Platform.isIOS) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(product.title),
              previousPageTitle: "Return",
            ),
            child: Material(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _content(context, product),
                ),
              ),
            ),
          );
        }

        return Scaffold(
            appBar: CustomAppBar(title: product.title, backButtonLink: "/catalog"),
            body: _content(context, product)
        );
      },
    );
  }

  Widget _content(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // square image
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // title
            Text(product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
            ),

            const SizedBox(height: 10),

            // price
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            // description
            Text(product.description),

            const SizedBox(height: 28),

            // add button
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  _addToCart(context, product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add to cart', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      )
    );
  }

}
