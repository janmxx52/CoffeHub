import '../firebase/home_service.dart';
import '../models/product_model.dart';

class HomeRepository {
  final HomeService _service = HomeService();

  Future<List<ProductModel>> getProducts() {
    return _service.getProducts();
  }
}