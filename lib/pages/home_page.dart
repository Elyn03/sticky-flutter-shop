import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/viewModels/products_view_model.dart';
import 'package:sticky_flutter_shop/widgets/app_bar.dart';
import '../widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CustomAppBar(title: 'Sticky Shop'),
      drawer: const NavBar(),
      body: Consumer<ProductsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final products = viewModel.products.take(3).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    "https://plus.unsplash.com/premium_vector-1747853823499-755b7020afcd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTI0fHx8ZW58MHx8fHx8",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 32),

                // Best Seller Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: const Text(
                    'Best Seller Stickers',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                // Products Horizontal Scroll
                SizedBox(
                  height: 300,
                  child: Center(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SizedBox(
                          width: 180,
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.network(
                                    product.thumbnail!,
                                    height: 220,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    product.title ?? 'Sticker',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // About Sticky Shop in a Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'About Sticky Shop',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Sticky Shop is your go-to place for high-quality stickers! '
                                'We offer a wide variety of designs for laptops, phones, notebooks, '
                                'water bottles, and more. Whether you love cute illustrations, '
                                'motivational quotes, or custom designs, we have something for everyone.\n\n'

                                'Our mission is to make everyday items fun and unique, allowing you to '
                                'express your personality wherever you go. Each sticker is crafted with '
                                'durable materials that are waterproof and long-lasting.\n\n'

                                'Join thousands of happy customers who have decorated their world with '
                                'Sticky Shop stickers. Discover our collection, personalize your items, '
                                'and let your creativity shine!',
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48), // extra space at the bottom
              ],
            ),
          );
        },
      ),
    );
  }
}
