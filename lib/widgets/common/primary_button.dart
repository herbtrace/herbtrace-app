import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.green,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: backgroundColor ?? Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
    );

    final textStyle = TextStyle(
      fontSize: fontSize ?? 16,
      color: textColor ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
    );

    if (isLoading) {
      return SizedBox(
        width: width,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: null,
          child: const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );
    }

    final Widget buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: textColor ?? Colors.white),
              const SizedBox(width: 8),
              Text(text, style: textStyle),
            ],
          )
        : Text(text, style: textStyle);

    return SizedBox(
      width: width,
      child: icon != null
          ? ElevatedButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: buttonChild,
            )
          : ElevatedButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: buttonChild,
            ),
    );
  }

  factory PrimaryButton.fullWidth({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return PrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      width: double.infinity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      padding: padding,
    );
  }
}
