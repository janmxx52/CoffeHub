/// Các lựa chọn size của sản phẩm
enum SizeOption {
  medium(label: 'M', fullLabel: 'Medium', extraPrice: 0),
  large(label: 'L', fullLabel: 'Large', extraPrice: 10000);

  const SizeOption({
    required this.label,
    required this.fullLabel,
    required this.extraPrice,
  });

  final String label;
  final String fullLabel;

  /// Giá thêm so với giá gốc
  final int extraPrice;

  String get displayName => '$label ($fullLabel)';
}
