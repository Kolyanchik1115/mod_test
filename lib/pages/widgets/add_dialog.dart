import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/services/admob_service.dart';

class RewardedAdButton extends StatefulWidget {
  const RewardedAdButton({Key? key}) : super(key: key);

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  RewardedAd? rewardedAd;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
  }

  void _createRewardedAd() {
    RewardedAd.load(
      request: const AdRequest(),
      adUnitId: AdModService.rewardedAdUnitId!,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => setState(() => rewardedAd = ad),
        onAdFailedToLoad: (LoadAdError error) =>
            setState(() => rewardedAd = null),
      ),
    );
  }

  void _onPressed() {
    if (_isLoading) return;
    _toggleIsLoading();
    _periodicCheckAdToShow();
  }

  void _toggleIsLoading() {
    _isLoading = !_isLoading;
    setState(() {});
    Future.delayed(const Duration(seconds: 6)).then((_) {
      _isLoading = !_isLoading;
      setState(() {});
    });
  }

  void _periodicCheckAdToShow() {
    int count = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 3 && _isLoading) {
        _showRewardedAd();
        count++;
      } else {
        timer.cancel();
      }
    });
  }

  void _showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) =>
            _afterWatchingRewardedAd(),
      );
      rewardedAd = null;
    }
  }

  void _afterWatchingRewardedAd() async {
    // этот метод вызывать после просмотра рекламы на кнопке  watch add
    await LaunchApp.openApp(androidPackageName: 'com.mojang.minecraftpe');
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.mojang.minecraftpe');
    if (isInstalled) {
      await LaunchApp.openApp(androidPackageName: 'com.mojang.minecraftpe');

//тут реализовать скачивание и замену мода

      // final bytes =
      //     await rootBundle.load('assets/mod/shader-addon.mcpack');
      // final list = bytes.buffer.asUint8List();
      // final tempDir = await getTemporaryDirectory();
      // final file =
      //     await File('${tempDir.path}/shader-addon.mcpack').create();
      // file.writeAsBytesSync(list);
    } else {
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.deepPurple,
        content: Text(
          'Minecraft не установлен на вашем телефоне',
          style: TextStyle(fontSize: 17),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _isLoading ? Colors.grey : Colors.deepPurpleAccent;
    return Stack(
      children: [
        AppButtonWidget(
          color: color,
          shadowColor: color,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 21,
                height: 21,
              ),
              const Text('WATCH AD'),
              Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _isLoading ? null : Colors.deepPurple,
                ),
                width: 21,
                height: 21,
                child: _isLoading
                    ? CircularProgressIndicator(color: color)
                    : const FittedBox(child: Text('AD')),
              ),
            ],
          ),
          height: 53,
          width: 230,
          onPressed: _isLoading ? null : _onPressed,
        ),
        Positioned(
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.deepPurple,
            ),
            width: 21,
            height: 21,
            child: const FittedBox(child: Text('AD')),
          ),
        ),
      ],
    );
  }
}
