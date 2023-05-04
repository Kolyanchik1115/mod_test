import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ShaderMod/pages/widgets/button_widget.dart';
import 'package:ShaderMod/resources/app_colors.dart';
import 'package:ShaderMod/resources/app_consts.dart';
import 'package:ShaderMod/resources/app_texts.dart';
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Если вы согласны с ',
                style: AppText.txt3,
                children: [
                  TextSpan(
                    text: 'Политикой конфиденциальности',
                    style: AppText.txt6,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launchUrlString(
                          AppConstantsString.privacyPolicy,
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                  ),
                  const TextSpan(text: '  нажмите СТАРТ', style: AppText.txt3),
                ],
              ),
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
