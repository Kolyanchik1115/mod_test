import 'dart:developer';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/resources/addmob_ids.dart';

class AdModService {
  static InterstitialAd? interstitialAd;
  static AppOpenAd? appOpenAd;
  static bool isAppOpenAdLoaded = false;

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

  static final BannerAdListener bannerAdListener =
      BannerAdListener(onAdLoaded: (ad) {
    log('Ad loaded.');
  }, onAdFailedToLoad: (ad, error) {
    ad.dispose();
    log('Ad failed to load $error');
  }, onAdOpened: (ad) {
    log('ad opened');
  }, onAdClosed: (ad) {
    log('ad closed');
  });

  static void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdModService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => interstitialAd = null,
      ),
    );
  }

  static Future<void> initializeAdMod() async {
    await MobileAds.instance.initialize();

    AppOpenAd.load(
      adUnitId: AdMobIds.androidAppOpenAdUnitId,
      request: const AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          isAppOpenAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          appOpenAd = null;
          isAppOpenAdLoaded = false;
        },
      ),
    );
  }

  static void showAppOpenAdIfAvailable() {
    if (appOpenAd == null || !isAppOpenAdLoaded) {
      return;
    }

    appOpenAd?.show();
    isAppOpenAdLoaded = false;
  }
}
