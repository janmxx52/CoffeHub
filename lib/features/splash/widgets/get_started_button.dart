import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class GetStartedButton extends StatefulWidget {
  final VoidCallback onPressed;

  const GetStartedButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.96 : 1,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: _pressed
                ? AppColors.amber.withOpacity(0.85)
                : AppColors.amber,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.amber.withOpacity(0.35),
                blurRadius: 30,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: const Text(
            "GET STARTED",
            textAlign: TextAlign.center,
            style: AppTextStyles.splashButton,
          ),
        ),
      ),
    );
  }
}