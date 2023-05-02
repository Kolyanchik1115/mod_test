import 'package:flutter/material.dart';
import 'package:mod_test/resources/utils/colors.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    this.width,
    this.height,
    required this.shadowColor,
    required this.child,
    this.borderRadius,
    this.gradient, this.color,
  });

  final double? width;
  final double? height;
  final Color shadowColor;
  final Color? color;
  final double? borderRadius;
  final Gradient? gradient;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? height ?? 0 / 2),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
