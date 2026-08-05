import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../cart/screens/cart_screen.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _productRepo = ProductRepository.instance;

  ProductCategory? _selectedCategory;

  List<ProductModel> get _filteredProducts {
    if (_selectedCategory == null) {
      return _productRepo.getAllProducts();
    }
    return _productRepo.getProductsByCategory(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final cartCount = context.watch<CartProvider>().totalItemCount;

    return Scaffold(
      backgroundColor: AppColors.espresso,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C1810), AppColors.espresso],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────
              _HomeHeader(
                userName: user?.fullName ?? 'Bạn',
                cartCount: cartCount,
              ),

              const SizedBox(height: 24),

              // ── Filter categories ────────────────────────
              _CategoryFilter(
                selected: _selectedCategory,
                onSelect: (cat) =>
                    setState(() => _selectedCategory = cat),
              ),

              const SizedBox(height: 20),

              // ── Section title ────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory == null
                          ? 'Tất Cả Sản Phẩm'
                          : _selectedCategory!.displayName,
                      style: const TextStyle(
                        fontFamily: 'Fraunces',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cream,
                      ),
                    ),
                    Text(
                      '${_filteredProducts.length} món',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 13,
                        color: AppColors.cream.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Product grid ─────────────────────────────
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: _filteredProducts[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.userName,
    required this.cartCount,
  });

  final String userName;
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào 👋',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 13,
                    color: AppColors.cream.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userName,
                  style: const TextStyle(
                    fontFamily: 'Fraunces',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cream,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

              // Logo & Cart & Logout icons
          Row(
            children: [
              // Brand logo mini
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.amber.withOpacity(0.25),
                  ),
                ),
                child: const Text(
                  'CoffeeHub',
                  style: TextStyle(
                    fontFamily: 'Fraunces',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.amber,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Cart icon với badge
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, CartScreen.routeName),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.cream,
                        size: 22,
                      ),
                    ),
                    if (cartCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.espresso,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.espresso,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              const SizedBox(width: 10),

              // Logout icon
              GestureDetector(
                onTap: () async {
                  // Xóa giỏ hàng khi đăng xuất
                  context.read<CartProvider>().clearCart();
                  
                  // Đăng xuất khỏi Firebase
                  await context.read<AuthProvider>().logout();
                  
                  if (!context.mounted) return;

                  // Quay lại màn hình Login và xóa toàn bộ lịch sử trang
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/login', 
                    (route) => false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Category Filter ───────────────────────────────────────────────────────

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({
    required this.selected,
    required this.onSelect,
  });

  final ProductCategory? selected;
  final ValueChanged<ProductCategory?> onSelect;

  static const _categories = [
    null,
    ProductCategory.tra,
    ProductCategory.traSua,
    ProductCategory.caPhe,
    ProductCategory.freeze,
  ];

  static const _labels = ['Tất Cả', 'Trà', 'Trà Sữa', 'Cà Phê', 'Freeze'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final cat = _categories[i];
          final isSelected = selected == cat;

          return GestureDetector(
            onTap: () => onSelect(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.amber
                    : Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.amber
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              child: Text(
                _labels[i],
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.espresso
                      : AppColors.cream.withOpacity(0.65),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}