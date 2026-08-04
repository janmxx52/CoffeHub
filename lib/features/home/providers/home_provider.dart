import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider();

  final ProductRepository _repository = ProductRepository();

  List<ProductModel> _products = [];

  bool _isLoading = false;

  String? _errorMessage;

  List<ProductModel> get products => _products;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _products = await _repository.getProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts();
  }
}