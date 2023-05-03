import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_texts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SplashScreenContent extends StatefulWidget {
  final void Function() onPressed;

  const SplashScreenContent({
    super.key,
    required this.onPressed,
  });

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  late StreamSubscription<InternetConnectionStatus> connectionStatus;
  late bool check;

  @override
  void initState() {
    connectionStatus =
        InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        check = true;
      } else {
        check = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Отстутствует интернет подключение'),
      backgroundColor: AppColors.error,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text(
              'Если вы согласны с ',
              style: AppText.txt1,
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
                    style: AppText.txt1.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(' нажмите СТАРТ', style: AppText.txt1),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        AppButtonWidget(
          shadowColor: AppColors.white,
          color: AppColors.white,
          title: const Text('СТАРТ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          height: 58,
          width: 184,
          onPressed: () => check == true
              ? widget.onPressed()
              : ScaffoldMessenger.of(context).showSnackBar(snackBar),
        ),
      ],
    );
  }
}
