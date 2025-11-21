import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/models/product.dart';
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
  final _queryController = TextEditingController();
  String searchQuery = "";
  String dropdownValue = "All";

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Catalog'),
      drawer: const NavBar(),
      body: Consumer<ProductsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.hasError) {
            return _buildError(viewModel);
          }

          // generate category list
          final categories = viewModel.products
              .map((product) => product.category)
              .toSet()
              .toList()
            ..sort();
          if (!categories.contains("All")) categories.insert(0, "All");

          // filter products
          final filteredProducts = viewModel.products.where((product) {
            final matchesSearch = product.title.toLowerCase().contains(searchQuery.toLowerCase());
            final matchesCategory = dropdownValue == "All" || product.category == dropdownValue;
            return matchesSearch && matchesCategory;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text('${filteredProducts.length} products'),
                    const SizedBox(width: 500),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _queryController,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() => searchQuery = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        ),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              dropdownValue = value;
                            });
                          }
                        },
                        items: categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 5 : 2,
                    childAspectRatio: kIsWeb ? 0.75 : 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return _productCard(product);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildError(ProductsViewModel viewModel) {
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
            child: const Text('Retry'),
          ),
        ],
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
                style: const TextStyle(fontSize: 16),
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
