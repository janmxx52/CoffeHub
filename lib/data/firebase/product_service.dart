import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .get();

    debugPrint("========== PRODUCTS ==========");
    debugPrint("Count = ${snapshot.docs.length}");

    for (final doc in snapshot.docs) {
      debugPrint(doc.data().toString());
    }

    return snapshot.docs
        .map((e) => ProductModel.fromDocument(e))
        .toList();
  }
}