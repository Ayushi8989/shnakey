import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/Snakey/pregame.dart';
import 'package:neon/utils/colors.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key, required this.points});

  final points;
  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
    VideoloadAd();
  }

  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool t = false;
  bool t1 = false;
  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  final rewardeadUnit = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';
  RewardedAd? _rewardedAd;
  void VideoloadAd() {
    RewardedAd.load(
      adUnitId: rewardeadUnit,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
                VideoloadAd();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C0731),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset(
                "assets/snakey.png",
                height: 70,
              ),
              const SizedBox(height: 16),
              const Text(
                'Congratulations! ',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    color: colorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'You won the Game',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    color: colorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 36),
              Image.asset(
                "assets/WinScreen.png",
                height: 120,
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Points: ',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: colorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.points,
                    style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: colorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SnakeyPreGame();
                    },
                  ));
                },
                child: Container(
                  height: 56,
                  width: 196.0,
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromRGBO(233, 60, 229, 1),
                          Color.fromRGBO(131, 42, 187, 1),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const AutoSizeText(
                    'Play Again',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SnakeyPreGame();
                    },
                  ));
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      color: AppColor.lightPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              (_bannerAd != null)
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: MaterialButton(
                          onPressed: () => {},
                          child: SafeArea(
                            child: SizedBox(
                              width: AdSize.fullBanner.width.toDouble(),
                              height: AdSize.fullBanner.height.toDouble(),
                              child: AdWidget(ad: _bannerAd!),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text("No Banner Ad"),
            ],
          ),
        ),
      ),
    );
  }
}
