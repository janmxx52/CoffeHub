class Validators {
  Validators._();

  /// Họ và tên
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }

    if (value.trim().length < 2) {
      return 'Họ và tên phải có ít nhất 2 ký tự';
    }

    return null;
  }

  /// Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }

    final emailRegex = RegExp(
      r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  /// Mật khẩu
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }

    return null;
  }

  /// Xác nhận mật khẩu
  static String? validateConfirmPassword(
      String? password,
      String? confirmPassword,
      ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }

    if (password != confirmPassword) {
      return 'Mật khẩu xác nhận không khớp';
    }

    return null;
  }

  /// Số điện thoại
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }

    final phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Số điện thoại không hợp lệ';
    }

    return null;
  }


  /// Địa chỉ
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập địa chỉ';
    }

    if (value.trim().length < 5) {
      return 'Địa chỉ quá ngắn';
    }

    return null;
  }

  /// Tên sản phẩm
  static String? validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên sản phẩm';
    }

    return null;
  }

  /// Giá
  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập giá';
    }

    final price = double.tryParse(value);

    if (price == null || price <= 0) {
      return 'Giá không hợp lệ';
    }

    return null;
  }
}