import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/home/home_page.dart';
import 'package:mod_test/pages/splash/widgets/splash_screen_content.dart';

import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/splash_widget.dart';
import 'package:mod_test/resources/addmob_ids.dart';
import 'package:mod_test/resources/app_images.dart';
import 'package:mod_test/services/admob_service.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late bool _isLoading;

  void _onPressed() {
    if (_isLoading) return;
    _isLoading = true;

    AdModService.createInterstitialAd();
    AdModService.periodicCheckAdToShow(
      setState: setState,
      isLoading: _isLoading,
      showAd: () => AdModService.showInterstitialAd(_onAdClose, setState),
    );
  }

  void _onAdClose() {
    _isLoading = false;
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    AdModService.createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Expanded(
              flex: 3,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(AppImages.splashImage)),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: _isLoading
                    ? const SplashLoading()
                    : SplashScreenContent(
                        onPressed: _onPressed,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
