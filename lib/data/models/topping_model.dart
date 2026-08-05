import 'package:flutter/foundation.dart';

/// Model đại diện cho một loại topping
@immutable
class ToppingModel {
  const ToppingModel({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;

  /// Giá topping (VNĐ)
  final int price;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ToppingModel && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ToppingModel(id: $id, name: $name, price: $price)';
}

/// Danh sách topping cố định của ứng dụng
class AppToppings {
  AppToppings._();

  static const ToppingModel tranChauTrang = ToppingModel(
    id: 'tct',
    name: 'Trân Châu Trắng',
    price: 10000,
  );

  static const ToppingModel tranChauDuongDen = ToppingModel(
    id: 'tcdd',
    name: 'Trân Châu Đường Đen',
    price: 10000,
  );

  static const ToppingModel thachDao = ToppingModel(
    id: 'tda',
    name: 'Thạch Đào',
    price: 10000,
  );

  static const ToppingModel kemPhoMai = ToppingModel(
    id: 'kpm',
    name: 'Kem Phô Mai',
    price: 10000,
  );

  static const ToppingModel whippingCream = ToppingModel(
    id: 'wc',
    name: 'Whipping Cream',
    price: 10000,
  );

  static const List<ToppingModel> all = [
    tranChauTrang,
    tranChauDuongDen,
    thachDao,
    kemPhoMai,
    whippingCream,
  ];
}
