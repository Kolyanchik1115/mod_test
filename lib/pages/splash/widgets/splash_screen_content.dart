import 'package:flutter/material.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
              'Если вы согласны с ',
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await launchUrlString(
                      AppConstantsString.privacyPolicy,
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: textStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(' нажмите Start', style: textStyle),
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
                fontWeight: FontWeight.w700,
              )),
          height: 58,
          width: 184,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
