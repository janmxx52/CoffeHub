import 'package:flutter/foundation.dart';

/// Danh mục sản phẩm
enum ProductCategory {
  tra('Trà'),
  traSua('Trà Sữa'),
  caPhe('Cà Phê'),
  freeze('Freeze');

  const ProductCategory(this.displayName);
  final String displayName;
}

/// Model đại diện cho một sản phẩm
@immutable
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imageAsset,
    required this.category,
    this.isAvailable = true,
  });

  final String id;
  final String name;
  final String description;

  /// Giá gốc (VNĐ) — chưa bao gồm size/topping
  final int basePrice;

  /// Đường dẫn tới asset ảnh sản phẩm
  final String imageAsset;

  final ProductCategory category;
  final bool isAvailable;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ProductModel && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductModel(id: $id, name: $name)';
}
