import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mod_test/resources/app_colors.dart';

class IconContainer extends StatelessWidget {
  final SvgPicture svg;
  final VoidCallback onPressed;
  final String text;
  const IconContainer({
    required this.svg,
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: AppColors.icon,
            ),
            width: 50,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: svg,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
