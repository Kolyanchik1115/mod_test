import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ShaderMod/resources/addmob_ids.dart';

abstract class AdModService {
  AdModService._();

  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;
  static Timer? _timer;

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return AdMobIds.androidRewardedAdUnitId;
    } else {
      return AdMobIds.iosRewardedAdUnitId;
    }
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return AdMobIds.androidInterstitialAdUnitId;
    } else {
      return AdMobIds.iosInterstitialAdUnitId;
    }
  }

  static void createInterstitialAd() {
    InterstitialAd.load(
      request: const AdRequest(),
      adUnitId: AdMobIds.androidInterstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  static void createRewardedAd() {
    RewardedAd.load(
        request: const AdRequest(),
        adUnitId: AdModService.rewardedAdUnitId!,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => _rewardedAd = ad,
            onAdFailedToLoad: (LoadAdError error) => _rewardedAd = null));
  }

  static void showInterstitialAd(
    VoidCallback onAdClosed,
    Function onFailedToShow,
  ) {
    if (_interstitialAd != null) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (Ad ad) {
          ad.dispose();
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (Ad ad, error) {
          ad.dispose();
          createInterstitialAd();
          onFailedToShow(() {});
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
      _timer?.cancel();
    }
  }

  static void showRewardedAd({
    required VoidCallback onAdClosed,
    required Function onGettingRewards,
    required Function updateState,
  }) {
    if (_rewardedAd != null) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (Ad ad) {
          onAdClosed();
          updateState(false);
          ad.dispose();
          createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (Ad ad, error) {
          ad.dispose();
          updateState(false);
          createRewardedAd();
          Flurry.logEvent('Failed to show rewarded ad: $error');
        },
      );
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onGettingRewards();

          Flurry.logEvent('AD Reward was getting');
          createRewardedAd();
        },
      );
      _rewardedAd = null;
      _timer?.cancel();
      updateState(false);
    }
  }

  static void periodicCheckAdToShow({
    required bool isLoading,
    required Function showAd,
    required Function setLoading,
  }) {
    setLoading(true);
    int count = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 9 && isLoading) {
        showAd();
        count++;
      } else {
        _timer?.cancel();
        setLoading(false);
      }
    });
  }
}
