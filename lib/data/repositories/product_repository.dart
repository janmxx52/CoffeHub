import '../models/product_model.dart';

/// Repository cung cấp dữ liệu sản phẩm.
/// Hiện tại dùng static local data — có thể mở rộng sang Firestore sau.
class ProductRepository {
  ProductRepository._();

  static final ProductRepository instance = ProductRepository._();

  /// Danh sách 9 sản phẩm của CoffeeHub
  static final List<ProductModel> _products = [
    const ProductModel(
      id: 'tra_sen_vang',
      name: 'Trà Sen Vàng',
      description:
          'Hương trà sen tinh khiết pha cùng mật ong nguyên chất, thanh mát và dịu ngọt tự nhiên.',
      basePrice: 45000,
      imageAsset: 'assets/images/tra_sen_vang.png',
      category: ProductCategory.tra,
    ),
    const ProductModel(
      id: 'tra_thach_dao',
      name: 'Trà Thạch Đào',
      description:
          'Trà xanh thơm dịu kết hợp thạch đào mát lạnh, mang hương vị mùa hè tươi mới.',
      basePrice: 45000,
      imageAsset: 'assets/images/tra_thach_dao.png',
      category: ProductCategory.tra,
    ),
    const ProductModel(
      id: 'freeze_ca_phe_phin',
      name: 'Freeze Cà Phê Phin',
      description:
          'Cà phê phin đậm đà hoà quyện với đá xay mịn, đậm vị cà phê Việt truyền thống.',
      basePrice: 55000,
      imageAsset: 'assets/images/freeze_ca_phe_phin.png',
      category: ProductCategory.freeze,
    ),
    const ProductModel(
      id: 'freeze_cookies_cream',
      name: 'Freeze Cookies & Cream',
      description:
          'Đá xay kem sữa thơm béo trộn lẫn bánh quy Oreo giòn tan, ngọt ngào khó cưỡng.',
      basePrice: 59000,
      imageAsset: 'assets/images/freeze_cookies_cream.png',
      category: ProductCategory.freeze,
    ),
    const ProductModel(
      id: 'tra_o_long',
      name: 'Trà Ô Long',
      description:
          'Trà Ô Long thượng hạng với hương thơm đặc trưng, vị trà thanh tao và hậu ngọt nhẹ.',
      basePrice: 45000,
      imageAsset: 'assets/images/tra_o_long.png',
      category: ProductCategory.tra,
    ),
    const ProductModel(
      id: 'tra_sua',
      name: 'Trà Sữa',
      description:
          'Trà sữa truyền thống với vị trà đen đậm đà pha cùng sữa tươi béo ngậy, cực kỳ quen thuộc.',
      basePrice: 49000,
      imageAsset: 'assets/images/tra_sua.png',
      category: ProductCategory.traSua,
    ),
    const ProductModel(
      id: 'tra_xanh',
      name: 'Trà Xanh',
      description:
          'Trà xanh Nhật Bản matcha thượng hạng, thanh mát tự nhiên và giàu chất chống oxy hóa.',
      basePrice: 49000,
      imageAsset: 'assets/images/tra_xanh.png',
      category: ProductCategory.tra,
    ),
    const ProductModel(
      id: 'ca_phe_sua_da',
      name: 'Cà Phê Sữa Đá',
      description:
          'Cà phê phin đậm đà pha với sữa đặc nguyên chất, rót qua đá lạnh — hương vị Việt thuần túy.',
      basePrice: 39000,
      imageAsset: 'assets/images/ca_phe_sua_da.png',
      category: ProductCategory.caPhe,
    ),
    const ProductModel(
      id: 'freeze_chocolate',
      name: 'Freeze Chocolate',
      description:
          'Socola Bỉ nguyên chất đá xay mịn phủ kem tươi, ngọt ngào và béo ngậy đến giọt cuối cùng.',
      basePrice: 59000,
      imageAsset: 'assets/images/freeze_chocolate.png',
      category: ProductCategory.freeze,
    ),
  ];

  /// Trả về toàn bộ danh sách sản phẩm
  List<ProductModel> getAllProducts() => List.unmodifiable(_products);

  /// Tìm sản phẩm theo id
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Lọc sản phẩm theo danh mục
  List<ProductModel> getProductsByCategory(ProductCategory category) =>
      _products.where((p) => p.category == category).toList();
}
