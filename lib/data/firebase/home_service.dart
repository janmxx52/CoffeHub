import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class HomeService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot =
    await _firestore.collection('products').get();

    return snapshot.docs
        .map(ProductModel.fromDocument)
        .toList();
  }
}