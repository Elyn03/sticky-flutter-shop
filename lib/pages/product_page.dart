import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_flutter_shop/services/api_mock.dart';
import 'package:sticky_flutter_shop/models/products.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';

class ProductPage extends StatelessWidget {
  final int productId;
 
  const ProductPage({super.key, required this.productId});

  Future<void> _addToCart() async {
    print("test");
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

        return Scaffold(
          appBar: CustomAppBar(title: product.title, backButtonLink: "/catalog"),
          body: Padding(
            padding: const EdgeInsets.all(16),
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
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Ajouter au panier', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
