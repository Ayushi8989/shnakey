import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/Database/database.dart';

import '../utils/global_variable.dart';

class AdBannerController extends GetxController {
  late BannerAd _bannerAd;
  BannerAd get bannerAd => _bannerAd;

  // ca-app-pub-3940256099942544/6300978111

  @override
  void onInit() {
    super.onInit();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void onClose() {
    _bannerAd.dispose();
    super.onClose();
  }

  Widget buildBannerAd() {
    return SizedBox(
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }
}

class RewardedAdController extends GetxController {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  int _rewardedAdCount = 0;
  Timer? _reloadTimer;

  bool get isAdLoaded => _isAdLoaded;
  Rx<Duration> _remainingTime = Duration(seconds: 20).obs;

  @override
  void onInit() {
    super.onInit();
    loadRewardedAd();
  }

  @override
  void onClose() {
    _rewardedAd?.dispose();
    _reloadTimer?.cancel();
    super.onClose();
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/5224354917', // Replace with your ad unit ID
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          update();
          print('Rewarded ad loaded.');
        },
        onAdFailedToLoad: (error) {
          print('Failed to load rewarded ad: $error');
        },
      ),
    );
  }

  void showRewardedAd() {
    final firebaseController = Get.find<FirebaseController>();

    if (_rewardedAd != null && _isAdLoaded && _rewardedAdCount < 3) {
      if (_reloadTimer != null && _reloadTimer!.isActive) {
        // Show Snackbar indicating time remaining
        final formattedTime =
            '${_remainingTime.value.inMinutes.remainder(60)}:${_remainingTime.value.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        Get.snackbar(
          'Please wait',
          'You need to wait for $formattedTime to view the rewarded ad again.',
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      } else {
        _rewardedAd!.show(
          onUserEarnedReward: (Ad ad, RewardItem reward) {
            print('Reward earned: $reward');
            if (adShowCount.value < 3) {
              adShowCount.value++;
            }
            print(adShowCount.value);
            firebaseController.increaseLives();

            startReloadTimer();
          },
        );
        _rewardedAdCount++;
        if (_rewardedAdCount >= 3) {
          // User has viewed the rewarded ad 3 times, stop reloading
          _reloadTimer?.cancel();
        }
      }
    } else {
      final formattedTime =
          '${_remainingTime.value.inMinutes.remainder(60)}:${_remainingTime.value.inSeconds.remainder(60).toString().padLeft(2, '0')}';
      Get.snackbar(
        'Sorry',
        'Unable to show rewarded ad. Please try again after some time.',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
      loadRewardedAd();
      print('Unable to show rewarded ad.');
    }
  }

  void startReloadTimer() {
    print("start reload timer");
    _reloadTimer?.cancel();
    _reloadTimer = Timer(Duration(seconds: 20), () {
      loadRewardedAd();
      print("load called");
    });
  }
}

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  Timer? _reloadTimer;

  bool get isAdLoaded => _isAdLoaded;

  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    _reloadTimer?.cancel();
    super.onClose();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // Replace with your ad unit ID
      request: AdRequest(),

      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          update();
          startReloadTimer();
        },
        onAdFailedToLoad: (error) {
          print('Failed to load interstitial ad: $error');
        },
      ),
    );
  }

  void startReloadTimer() {
    _reloadTimer?.cancel();
    _reloadTimer = Timer(Duration(minutes: 5), () {
      loadInterstitialAd();
    });
  }

  void showInterstitialAd() {
    if (_isAdLoaded) {
      if (_reloadTimer?.isActive ?? false) {
        // Show snackbar indicating time remaining
        Get.snackbar(
          'Please wait',
          'You need to wait for the ad to view the interstitial ad.',
          duration: Duration(seconds: 5),
          colorText: Colors.white,
        );
      } else {
        _interstitialAd?.show();
      }
    } else {
      loadInterstitialAd();
      print('Interstitial ad is not loaded yet.');
    }
  }
}
