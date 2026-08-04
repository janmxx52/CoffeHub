import 'package:flutter/foundation.dart';
import 'product_model.dart';
import 'size_option.dart';
import 'topping_model.dart';

/// Model đại diện cho một item trong giỏ hàng
@immutable
class CartItemModel {
  const CartItemModel({
    required this.product,
    required this.selectedSize,
    required this.selectedToppings,
    required this.quantity,
  });

  final ProductModel product;
  final SizeOption selectedSize;

  /// Danh sách topping đã chọn
  final List<ToppingModel> selectedToppings;

  final int quantity;

  /// Giá của một ly (chưa nhân số lượng)
  int get unitPrice {
    final toppingTotal =
        selectedToppings.fold<int>(0, (sum, t) => sum + t.price);
    return product.basePrice + selectedSize.extraPrice + toppingTotal;
  }

  /// Tổng giá của item này (đã nhân số lượng)
  int get totalPrice => unitPrice * quantity;

  /// Tạo bản sao với số lượng mới
  CartItemModel copyWithQuantity(int newQuantity) {
    return CartItemModel(
      product: product,
      selectedSize: selectedSize,
      selectedToppings: selectedToppings,
      quantity: newQuantity,
    );
  }

  /// Kiểm tra xem hai item có cùng sản phẩm + size + topping không
  /// (dùng để gộp vào khi addItem)
  bool isSameConfiguration(CartItemModel other) {
    if (product.id != other.product.id) return false;
    if (selectedSize != other.selectedSize) return false;
    if (selectedToppings.length != other.selectedToppings.length) return false;

    final myIds = selectedToppings.map((t) => t.id).toSet();
    final otherIds = other.selectedToppings.map((t) => t.id).toSet();
    return myIds.containsAll(otherIds) && otherIds.containsAll(myIds);
  }

  @override
  String toString() =>
      'CartItemModel(product: ${product.name}, size: ${selectedSize.label}, '
      'toppings: ${selectedToppings.map((t) => t.name).join(', ')}, '
      'qty: $quantity, total: $totalPrice)';
}
