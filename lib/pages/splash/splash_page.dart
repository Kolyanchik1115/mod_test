import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/home/home_page.dart';

import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/splash_widget.dart';
import 'package:mod_test/resources/addmob_ids.dart';
import 'package:mod_test/resources/app_images.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  var isLoading = false;
  InterstitialAd? _interstitialAd;

  void _onPressed() {
    if (isLoading) return;
    _createInterstitialAd();
    _periodicCheckAdToShow();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      request: const AdRequest(),
      adUnitId: AdMobIds.androidInterstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void _periodicCheckAdToShow() {
    isLoading = true;
    setState(() {});
    int count = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 6 && isLoading) {
        _showInterstitialAd();
        count++;
      } else {
        _timer?.cancel();
        isLoading = false;
      }
    });
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          // _createInterstitialAd();
          _timer?.cancel();
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          isLoading = false;
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                child: isLoading
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
