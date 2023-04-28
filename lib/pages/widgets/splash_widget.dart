import 'package:flutter/material.dart';
import 'package:mod_test/resources/app_images.dart';

class SplashLoading extends StatefulWidget {
  const SplashLoading({Key? key}) : super(key: key);

  @override
  SplashLoadingState createState() => SplashLoadingState();
}

class SplashLoadingState extends State<SplashLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Image.asset(AppImages.splashLoading),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
