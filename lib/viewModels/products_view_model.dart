import 'package:flutter/foundation.dart';
import 'package:sticky_flutter_shop/models/products.dart';
import 'package:sticky_flutter_shop/services/api_mock.dart';

class ProductsViewModel extends ChangeNotifier {

  List<Product> _products = [];
  bool _isLoading = false;
  String _errorMessage = "";

  // Public getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage = "";
  bool get hasError => _errorMessage.isNotEmpty;


  // Constructor
  ProductsViewModel() {
    loadProducts();
  }

  // Load products
  Future<void> loadProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _products = await ApiMock.fetchProducts();
    } catch (err) {
      _errorMessage = "Impossible de charger les produits";
    }

    _isLoading = false;
    notifyListeners();
  }
}
