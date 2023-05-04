import 'package:flutter/material.dart';
import 'package:ShaderMod/pages/home/home_page.dart';
import 'package:ShaderMod/pages/splash/widgets/splash_screen_content.dart';
import 'package:ShaderMod/pages/widgets/splash_widget.dart';
import 'package:ShaderMod/resources/app_images.dart';
import 'package:ShaderMod/services/admob_service.dart';

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
        setLoading: (loading) => _setLoading(loading),
        isLoading: _isLoading,
        showAd: () {
          AdModService.showInterstitialAd(_onAdClose, setState);
          _onAdClose();
        });
  }

  _setLoading(bool loading) {
    _isLoading = loading;
    setState(() {});
  }

  void _onAdClose() {
    _isLoading = false;
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    AdModService.createRewardedAd();
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
