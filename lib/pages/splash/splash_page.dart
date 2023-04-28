import 'package:flutter/material.dart';

import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/splash_widget.dart';
import 'package:mod_test/resources/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late var isLoading = false;
  void toggleIsLoading() {
    isLoading = !isLoading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(189, 0, 255, 1),
            Color.fromRGBO(71, 0, 162, 1)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Image.asset(AppImages.splashImage),
          ),
          isLoading
              ? const Center(
                  child: SplashLoading(),
                )
              : SplashScreenContent(
                  onPressed: toggleIsLoading,
                )
        ],
      ),
    );
  }
}

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
      color: Colors.white,
    );
    return Column(
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
          shadowColor: Colors.white,
          color: Colors.white,
          title: const Text('START',
              style: TextStyle(
                  color: Colors.black,
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
