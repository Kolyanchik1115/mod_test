import 'dart:async';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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

  Future<void> _afterWatchingRewardedAd() async {
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.mojang.minecraftpe');
    if (isInstalled) {
      const url =
          'https://www.dropbox.com/s/5wc31t4yio8j2f8/spider.mcaddon?dl=1';
      final response = await http.get(Uri.parse(url));

      final getAddonDirectory = await getExternalStorageDirectory();

      final bytes = response.bodyBytes;
      const fileName = 'spider.mcaddon';
      final file = File('${getAddonDirectory!.path}/$fileName');
      await file.writeAsBytes(bytes);
     //все что выше работает, скачивает по тому пути выше

     // -> copyAddonToMinecraftDirectory функция копирования мода в папку майна  и она не работает 
     await copyAddonToMinecraftDirectory(fileName);
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

  Future<void> copyAddonToMinecraftDirectory(String fileName) async {
    try {
      const minecraftAddonsPath =
          '/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang';
      final getAddonDirectory =
          '/storage/emulated/0/Android/data/com.mcpe_shader.mod_test/files';
      final addonFile = File('$getAddonDirectory/$fileName');
      if (await addonFile.exists()) {
        await addonFile.copy(minecraftAddonsPath);
        print('Addon copied successfully!');
      } else {
        print('Addon file not found!');
      }
    } catch (e) {
      print('Error copying addon to Minecraft directory: $e');
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
