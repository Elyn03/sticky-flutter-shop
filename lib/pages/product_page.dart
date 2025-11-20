import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/services/api_mock.dart';
import 'package:sticky_flutter_shop/models/products.dart';

class ProductPage extends StatelessWidget {
  final int productId;

  const ProductPage({super.key, required this.productId});

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

        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.thumbnail),
                const SizedBox(height: 20),
                Text(product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Text(
                  product.formattedPrice,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Text(product.description),
              ],
            ),
          ),
        );
      },
    );
  }
}
