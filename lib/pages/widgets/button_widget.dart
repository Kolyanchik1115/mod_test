import 'package:flutter/material.dart';

import 'shadow_container.dart';

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
      child: ShadowContainer(
        width: width ?? double.infinity,
        height: height,
        color: color,
        shadowColor: shadowColor ?? color,
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
        ),),
    );
  }
}

