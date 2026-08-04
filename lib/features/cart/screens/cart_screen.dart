import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/cart_item_model.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────
            _CartAppBar(),

            // ── Nội dung ─────────────────────────────────
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, cart, _) {
                  if (cart.isEmpty) {
                    return _EmptyCart();
                  }
                  return _CartContent(cart: cart);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ───────────────────────────────────────────────────────────────

class _CartAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemCount = context.watch<CartProvider>().totalItemCount;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 20, 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.cream,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Giỏ Hàng',
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cream,
                    ),
                  ),
                  if (itemCount > 0)
                    Text(
                      '$itemCount món đã chọn',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 13,
                        color: AppColors.cream.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            ),
            if (itemCount > 0)
              GestureDetector(
                onTap: () => _showClearCartDialog(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.red.withOpacity(0.3)),
                  ),
                  child: const Text(
                    'Xóa tất cả',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Xóa giỏ hàng?',
          style: TextStyle(
            fontFamily: 'Fraunces',
            color: AppColors.cream,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Tất cả sản phẩm trong giỏ sẽ bị xóa.',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: AppColors.cream.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hủy',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: AppColors.cream.withOpacity(0.5),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clearCart();
              Navigator.pop(ctx);
            },
            child: const Text(
              'Xóa',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Giỏ hàng trống ────────────────────────────────────────────────────────

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.amber.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 56,
              color: AppColors.amber.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Giỏ hàng trống',
            style: TextStyle(
              fontFamily: 'Fraunces',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.cream,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hãy chọn những thức uống\nyêu thích của bạn nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14,
              color: AppColors.cream.withOpacity(0.45),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 36),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.amber,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Khám phá menu',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.espresso,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nội dung giỏ hàng ─────────────────────────────────────────────────────

class _CartContent extends StatelessWidget {
  const _CartContent({required this.cart});

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Danh sách item
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            itemCount: cart.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _CartItemCard(
                item: cart.items[index],
                index: index,
              );
            },
          ),
        ),

        // Footer tổng tiền + đặt hàng
        _CartFooter(totalPrice: cart.totalPrice),
      ],
    );
  }
}

// ─── Card từng item ─────────────────────────────────────────────────────────

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item, required this.index});

  final CartItemModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.amber.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon sản phẩm
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_cafe_rounded,
                  color: AppColors.amber,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),

              // Thông tin sản phẩm
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cream,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Size & Topping tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _TagChip(
                          label: 'Size ${item.selectedSize.label}',
                          color: AppColors.amber,
                        ),
                        ...item.selectedToppings.map(
                          (t) => _TagChip(
                            label: t.name,
                            color: const Color(0xFF7EB8A0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Nút xóa
              GestureDetector(
                onTap: () =>
                    context.read<CartProvider>().removeItem(index),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row: giá đơn vị + bộ điều chỉnh số lượng
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_formatPrice(item.unitPrice)} / ly',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        color: AppColors.cream.withOpacity(0.4),
                      ),
                    ),
                    Text(
                      _formatPrice(item.totalPrice),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.amber,
                      ),
                    ),
                  ],
                ),
              ),

              // Điều chỉnh số lượng
              Row(
                children: [
                  _SmallQtyButton(
                    icon: Icons.remove,
                    onTap: () =>
                        context.read<CartProvider>().decrementQuantity(index),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cream,
                      ),
                    ),
                  ),
                  _SmallQtyButton(
                    icon: Icons.add,
                    onTap: () =>
                        context.read<CartProvider>().incrementQuantity(index),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _SmallQtyButton extends StatelessWidget {
  const _SmallQtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.amber.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.amber.withOpacity(0.25)),
        ),
        child: Icon(icon, color: AppColors.amber, size: 16),
      ),
    );
  }
}

// ─── Footer: Tổng tiền & đặt hàng ─────────────────────────────────────────

class _CartFooter extends StatelessWidget {
  const _CartFooter({required this.totalPrice});

  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).padding.bottom + 20,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 15,
                  color: AppColors.cream.withOpacity(0.6),
                ),
              ),
              Text(
                _formatPrice(totalPrice),
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Nút đặt hàng
          GestureDetector(
            onTap: () {
              // TODO: Tích hợp flow thanh toán / đặt hàng
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    '🎉 Đặt hàng thành công! Chúng tôi đang chuẩn bị đơn của bạn.',
                    style: TextStyle(fontFamily: 'Outfit'),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
              context.read<CartProvider>().clearCart();
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.amber,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amber.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'ĐẶT HÀNG NGAY',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: AppColors.espresso,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helper ────────────────────────────────────────────────────────────────

String _formatPrice(int price) {
  final formatted = price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      );
  return '${formatted}đ';
}
