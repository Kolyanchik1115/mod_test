import 'dart:async';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/services/admob_service.dart';

import 'package:open_file/open_file.dart';

class RewardedAdButton extends StatefulWidget {
  const RewardedAdButton({Key? key}) : super(key: key);

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  RewardedAd? rewardedAd;
  Timer? _timer;
  var _isLoading = false;
  var filePath = '';

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
          Flurry.logEvent('Mod was downloaded');
          // Очень важно: чтобы переходило в это место при закрытии рекламы,
          // ни в коем случае нельзя диспосить рекламу при получении награды
          // в методе onUserEarnedReward при ее показе
          ad.dispose();
          _createRewardedAd();
          _afterDismissingRewardedAd();
          Navigator.of(context, rootNavigator: true).pop();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd();
          print('Failed to show rewarded ad: $error');
        },
      );

      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          Flurry.logEvent('AD Reward was getting');
          _createRewardedAd();
          _afterWatchingRewardedAd();
        },
      );
      _isLoading = false;
      setState(() {});
      _timer?.cancel();
      rewardedAd = null;
    }
  }

  Future<void> _afterDismissingRewardedAd() async {
    await OpenFile.open(filePath);
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
      final ready = await file.writeAsBytes(bytes);
      filePath = ready.path;
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
      ],
    );
  }
}
