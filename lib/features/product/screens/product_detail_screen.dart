import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/size_option.dart';
import '../../../data/models/topping_model.dart';
import '../../cart/providers/cart_provider.dart';
import '../providers/product_detail_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return ChangeNotifierProvider(
      create: (_) => ProductDetailProvider(product: product),
      child: const _ProductDetailBody(),
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductDetailProvider>();
    final product = provider.product;

    return Scaffold(
      backgroundColor: AppColors.espresso,
      body: Stack(
        children: [
          // ── Background gradient ──────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2C1810), AppColors.espresso],
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              // ── App Bar với ảnh sản phẩm ────────────────
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: const Color(0xFF2C1810),
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.cream,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: _ProductHeroImage(product: product),
                ),
              ),

              // ── Nội dung chính ──────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.espresso,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên & giá
                        _ProductNameAndPrice(provider: provider),
                        const SizedBox(height: 16),

                        // Mô tả
                        Text(
                          product.description,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            color: AppColors.cream.withOpacity(0.65),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Chọn size
                        _SectionTitle(title: 'Chọn Size'),
                        const SizedBox(height: 14),
                        _SizeSelector(provider: provider),
                        const SizedBox(height: 32),

                        // Chọn topping
                        _SectionTitle(title: 'Chọn Topping'),
                        const SizedBox(height: 6),
                        _ToppingSelector(provider: provider),
                        const SizedBox(height: 32),

                        // Số lượng
                        _SectionTitle(title: 'Số Lượng'),
                        const SizedBox(height: 14),
                        _QuantitySelector(provider: provider),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom Bar: Tổng giá + Thêm vào giỏ ────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _AddToCartBar(provider: provider),
          ),
        ],
      ),
    );
  }
}

// ─── Widget: Ảnh sản phẩm ──────────────────────────────────────────────────

class _ProductHeroImage extends StatelessWidget {
  const _ProductHeroImage({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3D1F10), Color(0xFF2C1810)],
        ),
      ),
      child: Center(
        child: Hero(
          tag: 'product_${product.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              product.imageAsset,
              height: 260,
              width: 260,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _PlaceholderImage(
                category: product.category,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({required this.category});

  final ProductCategory category;

  IconData get _icon {
    switch (category) {
      case ProductCategory.freeze:
        return Icons.ac_unit_rounded;
      case ProductCategory.caPhe:
        return Icons.coffee_rounded;
      default:
        return Icons.local_cafe_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 260,
      decoration: BoxDecoration(
        color: AppColors.amber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(_icon, size: 100, color: AppColors.amber.withOpacity(0.5)),
    );
  }
}

// ─── Widget: Tên & Giá ─────────────────────────────────────────────────────

class _ProductNameAndPrice extends StatelessWidget {
  const _ProductNameAndPrice({required this.provider});

  final ProductDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.amber.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  provider.product.category.displayName,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 11,
                    color: AppColors.amber.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                provider.product.name,
                style: const TextStyle(
                  fontFamily: 'Fraunces',
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cream,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Giá gốc
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Từ',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                color: AppColors.cream.withOpacity(0.4),
              ),
            ),
            Text(
              _formatPrice(provider.product.basePrice),
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Widget: Section Title ──────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Outfit',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.cream,
        letterSpacing: 0.3,
      ),
    );
  }
}

// ─── Widget: Chọn Size ─────────────────────────────────────────────────────

class _SizeSelector extends StatelessWidget {
  const _SizeSelector({required this.provider});

  final ProductDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: SizeOption.values.map((size) {
        final isSelected = provider.selectedSize == size;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => context
                  .read<ProductDetailProvider>()
                  .selectSize(size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.amber
                      : AppColors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.amber
                        : AppColors.amber.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      size.label,
                      style: TextStyle(
                        fontFamily: 'Fraunces',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.espresso
                            : AppColors.cream,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      size.fullLabel,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.espresso.withOpacity(0.7)
                            : AppColors.cream.withOpacity(0.5),
                      ),
                    ),
                    if (size.extraPrice > 0) ...[
                      const SizedBox(height: 4),
                      Text(
                        '+${_formatPrice(size.extraPrice)}',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.espresso.withOpacity(0.8)
                              : AppColors.amber.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Widget: Chọn Topping ──────────────────────────────────────────────────

class _ToppingSelector extends StatelessWidget {
  const _ToppingSelector({required this.provider});

  final ProductDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppToppings.all.map((topping) {
        final isSelected = provider.isToppingSelected(topping);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () =>
                context.read<ProductDetailProvider>().toggleTopping(topping),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.amber.withOpacity(0.14)
                    : Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.amber.withOpacity(0.6)
                      : Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.amber : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.amber
                            : AppColors.cream.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: AppColors.espresso,
                          )
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      topping.name,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.cream
                            : AppColors.cream.withOpacity(0.65),
                      ),
                    ),
                  ),
                  Text(
                    '+${_formatPrice(topping.price)}',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.amber
                          : AppColors.cream.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Widget: Số lượng ──────────────────────────────────────────────────────

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({required this.provider});

  final ProductDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QtyButton(
          icon: Icons.remove,
          onTap: () => context.read<ProductDetailProvider>().decrement(),
        ),
        const SizedBox(width: 20),
        Text(
          '${provider.quantity}',
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.cream,
          ),
        ),
        const SizedBox(width: 20),
        _QtyButton(
          icon: Icons.add,
          onTap: () => context.read<ProductDetailProvider>().increment(),
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.amber.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.amber.withOpacity(0.25),
          ),
        ),
        child: Icon(icon, color: AppColors.amber, size: 20),
      ),
    );
  }
}

// ─── Widget: Bottom Bar thêm vào giỏ ──────────────────────────────────────

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({required this.provider});

  final ProductDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.espresso,
        border: Border(
          top: BorderSide(
            color: AppColors.amber.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Tổng giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tổng cộng',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  color: AppColors.cream.withOpacity(0.45),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatPrice(provider.totalPrice),
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Nút thêm vào giỏ
          Expanded(
            child: GestureDetector(
              onTap: () {
                final cartItem = provider.buildCartItem();
                context.read<CartProvider>().addItem(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Đã thêm ${provider.product.name} vào giỏ hàng!',
                      style: const TextStyle(fontFamily: 'Outfit'),
                    ),
                    backgroundColor: AppColors.amber,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.amber,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.amber.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.espresso,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'THÊM VÀO GIỎ',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppColors.espresso,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helpers ───────────────────────────────────────────────────────────────

String _formatPrice(int price) {
  // Format: 45.000đ
  final formatted = price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      );
  return '${formatted}đ';
}
