import 'package:flutter/foundation.dart';
import '../../../data/models/cart_item_model.dart';

/// Provider quản lý trạng thái giỏ hàng toàn ứng dụng
class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  /// Danh sách item trong giỏ (read-only)
  List<CartItemModel> get items => List.unmodifiable(_items);

  /// Tổng số lượng món trong giỏ
  int get totalItemCount =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  /// Tổng giá trị giỏ hàng (VNĐ)
  int get totalPrice =>
      _items.fold<int>(0, (sum, item) => sum + item.totalPrice);

  /// Kiểm tra giỏ hàng có trống không
  bool get isEmpty => _items.isEmpty;

  /// Thêm sản phẩm vào giỏ.
  /// Nếu cùng cấu hình (sản phẩm + size + topping), tăng số lượng thay vì thêm mới.
  void addItem(CartItemModel newItem) {
    final existingIndex =
        _items.indexWhere((item) => item.isSameConfiguration(newItem));

    if (existingIndex != -1) {
      final existing = _items[existingIndex];
      _items[existingIndex] =
          existing.copyWithQuantity(existing.quantity + newItem.quantity);
    } else {
      _items.add(newItem);
    }

    notifyListeners();
  }

  /// Xóa item khỏi giỏ theo index
  void removeItem(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }

  /// Cập nhật số lượng của item.
  /// Nếu [quantity] <= 0, item sẽ bị xóa khỏi giỏ.
  void updateQuantity(int index, int quantity) {
    if (index < 0 || index >= _items.length) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWithQuantity(quantity);
    }

    notifyListeners();
  }

  /// Tăng số lượng item
  void incrementQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    final item = _items[index];
    _items[index] = item.copyWithQuantity(item.quantity + 1);
    notifyListeners();
  }

  /// Giảm số lượng item. Nếu về 0, item bị xóa.
  void decrementQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    final item = _items[index];
    if (item.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = item.copyWithQuantity(item.quantity - 1);
    }
    notifyListeners();
  }

  /// Xóa toàn bộ giỏ hàng
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
