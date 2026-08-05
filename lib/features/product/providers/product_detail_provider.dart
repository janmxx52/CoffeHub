import 'package:flutter/foundation.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/size_option.dart';
import '../../../data/models/topping_model.dart';

/// Provider quản lý state cục bộ cho màn hình chi tiết sản phẩm.
/// Được khởi tạo mới mỗi lần mở ProductDetailScreen.
class ProductDetailProvider extends ChangeNotifier {
  ProductDetailProvider({required this.product});

  final ProductModel product;

  /// Size hiện tại đang được chọn (mặc định: Medium)
  SizeOption _selectedSize = SizeOption.medium;
  SizeOption get selectedSize => _selectedSize;

  /// Các topping đang được chọn
  final Set<ToppingModel> _selectedToppings = {};
  Set<ToppingModel> get selectedToppings =>
      Set.unmodifiable(_selectedToppings);

  /// Số lượng (mặc định: 1)
  int _quantity = 1;
  int get quantity => _quantity;

  // ─── Computed ─────────────────────────────────────────────

  /// Giá topping đã chọn
  int get toppingTotal =>
      _selectedToppings.fold<int>(0, (sum, t) => sum + t.price);

  /// Giá một ly (chưa nhân số lượng)
  int get unitPrice =>
      product.basePrice + _selectedSize.extraPrice + toppingTotal;

  /// Tổng giá (đã nhân số lượng)
  int get totalPrice => unitPrice * _quantity;

  // ─── Actions ──────────────────────────────────────────────

  /// Thay đổi size đã chọn
  void selectSize(SizeOption size) {
    if (_selectedSize == size) return;
    _selectedSize = size;
    notifyListeners();
  }

  /// Bật/tắt chọn một topping
  void toggleTopping(ToppingModel topping) {
    if (_selectedToppings.contains(topping)) {
      _selectedToppings.remove(topping);
    } else {
      _selectedToppings.add(topping);
    }
    notifyListeners();
  }

  /// Kiểm tra topping có đang được chọn không
  bool isToppingSelected(ToppingModel topping) =>
      _selectedToppings.contains(topping);

  /// Tăng số lượng
  void increment() {
    _quantity++;
    notifyListeners();
  }

  /// Giảm số lượng (tối thiểu là 1)
  void decrement() {
    if (_quantity <= 1) return;
    _quantity--;
    notifyListeners();
  }

  /// Tạo CartItemModel từ trạng thái hiện tại để thêm vào giỏ
  CartItemModel buildCartItem() {
    return CartItemModel(
      product: product,
      selectedSize: _selectedSize,
      selectedToppings: _selectedToppings.toList(),
      quantity: _quantity,
    );
  }
}
