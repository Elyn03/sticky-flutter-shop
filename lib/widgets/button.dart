import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isLoading;
  final double? width;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    required this.text,
    this.isLoading = false,
    this.width,
    this.color,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.primary,
          foregroundColor: textColor ?? theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
