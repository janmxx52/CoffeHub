import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../product/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailScreen.routeName,
        arguments: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.amber.withOpacity(0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Ảnh sản phẩm ──────────────────────────
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Container(
                  color: AppColors.amber.withOpacity(0.07),
                  child: Hero(
                    tag: 'product_${product.id}',
                    child: Image.asset(
                      product.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _CategoryIcon(
                        category: product.category,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Thông tin sản phẩm ────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _categoryColor(product.category)
                          .withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category.displayName,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: _categoryColor(product.category),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Tên sản phẩm
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cream,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Giá & nút xem chi tiết
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatPrice(product.basePrice),
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.amber,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.espresso,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.category});

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    final icon = switch (category) {
      ProductCategory.freeze => Icons.ac_unit_rounded,
      ProductCategory.caPhe => Icons.coffee_rounded,
      ProductCategory.traSua => Icons.local_drink_rounded,
      _ => Icons.local_cafe_rounded,
    };

    return Center(
      child: Icon(
        icon,
        size: 50,
        color: AppColors.amber.withOpacity(0.3),
      ),
    );
  }
}

Color _categoryColor(ProductCategory category) {
  return switch (category) {
    ProductCategory.freeze => const Color(0xFF5BC4E8),
    ProductCategory.caPhe => const Color(0xFFC8873A),
    ProductCategory.traSua => const Color(0xFFE8A87C),
    _ => const Color(0xFF7EB8A0),
  };
}

String _formatPrice(int price) {
  final formatted = price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      );
  return '${formatted}đ';
}
