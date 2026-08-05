import '../firebase/product_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  ProductRepository();

  final ProductService _service = ProductService();

  Future<List<ProductModel>> getProducts() {
    return _service.getProducts();
  }
}