import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';
import 'product_card.dart';

class ProductSection extends StatelessWidget {
  final List<ProductModel> products;

  const ProductSection({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text("Chưa có sản phẩm"),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}