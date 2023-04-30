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
  Timer? _timer;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _createRewardedAd() {
    if (rewardedAd == null) {
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
  }

  void _onPressed() {
    if (_isLoading) return;
    if (rewardedAd == null) {
      _createRewardedAd();
    }
    _periodicCheckAdToShow();
  }

  void _periodicCheckAdToShow() {
    _isLoading = true;
    setState(() {});
    int count = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 6 && _isLoading) {
        _showRewardedAd();
        count++;
      } else {
        _timer?.cancel();
        _isLoading = false;
        setState(() {});
      }
    });
  }

  void _showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          // Очень важно: чтобы переходило в это место при закрытии рекламы,
          // ни в коем случае нельзя диспосить рекламу при получении награды
          // в методе onUserEarnedReward при ее показе
          ad.dispose();

          _createRewardedAd();
          Navigator.of(context, rootNavigator: true).pop();
          print('Rewarded ad dismissed');
        },
        // onAdWillDismissFullScreenContent: (ad) {
        //   ad.dispose();
        //   _createRewardedAd();
        //   print('Rewarded ad dismissed');
        // },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd();
          print('Failed to show rewarded ad: $error');
        },
      );

      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          // ad.dispose();

          _createRewardedAd();

          // _afterWatchingRewardedAd();
        },
      );
      _isLoading = false;
      setState(() {});
      _timer?.cancel();
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
