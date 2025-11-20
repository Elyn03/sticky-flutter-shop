import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/models/products.dart';
import 'package:sticky_flutter_shop/viewModels/products_view_model.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
import '../widgets/drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}
class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Catalog Page'),
      drawer: const NavBar(),
      body: Consumer<ProductsViewModel>(
        // Consumer is sort of "Await"
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(viewModel.errorMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadProducts(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kIsWeb ? 5 : 2,
              childAspectRatio: kIsWeb ? 0.75 : 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final product = viewModel.products[index];
              return _productCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _productCard(Product product) {
    return GestureDetector(
      onTap: () => context.go('/product/${product.id}'),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
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

              const SizedBox(height: 12),

              // title
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 16
                ),
              ),

              const SizedBox(height: 4),

              // price
              Text(
                product.formattedPrice,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}