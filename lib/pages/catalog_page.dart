import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Catalog")
      ),
      drawer: const NavBar(),
      body: const Center(child: Text('Catalog of stickers')),
    );
  }
}
