import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final Color? shadowColor;
  final Color color;
  final Widget title;
  final double? width;
  final double height;
  final void Function()? onPressed;

  const AppButtonWidget({
    Key? key,
    this.shadowColor,
    required this.color,
    required this.title,
    this.width,
    required this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.transparent,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          onPressed: onPressed,
          child: title,
        ),
      ),
    );
  }
}
