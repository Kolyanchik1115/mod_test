
import 'package:flutter/material.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/utils/colors.dart';

class SplashScreenContent extends StatelessWidget {
  final void Function() onPressed;

  const SplashScreenContent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      letterSpacing: 0.16,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.white,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text(
              'If you agree with the',
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {},
                    child: Text('Privacy Policy',
                        style: textStyle.copyWith(
                            decoration: TextDecoration.underline))),
                const Text(' click Start', style: textStyle),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        AppButtonWidget(
          shadowColor: AppColors.white,
          color: AppColors.white,
          title: const Text('START',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          height: 58,
          width: 184,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
