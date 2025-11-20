import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/viewModels/products_view_model.dart';
import '../widgets/drawer.dart';
import 'package:go_router/go_router.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}
class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      drawer: const NavBar(),
      body: Consumer<ProductsViewModel>(
        // Consumer c'est un genre de await de widget
        // builder = fonction qui décrit quoi afficher selon l’état du ViewModel
        // context = contexte Flutter habituel
        // viewModel = instance de ProductsViewModel (accès à products, isLoading, etc.)
        // child = widget statique (non utilisé ici, mais utile si on veut éviter de rebuild un widget lourd)
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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              final product = viewModel.products[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text(product.formattedPrice),
                  onTap: () {
                    context.go('/product/${product.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}