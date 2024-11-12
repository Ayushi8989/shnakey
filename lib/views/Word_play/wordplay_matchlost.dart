import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/views/Word_play/wordplay_boarding.dart';
import 'package:neon/views/Word_play/wordplay_game.dart';
class lost extends StatefulWidget {
  const lost({super.key});

  @override
  State<lost> createState() => _lostState();
}

class _lostState extends State<lost> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  String Msg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
    Interstitialload();
  }

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
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

  InterstitialAd? _interstitialAd;
  // TODO: replace this test ad unit with your own ad unit.
  final ad = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  /// Loads an interstitial ad.
  void Interstitialload() {
    InterstitialAd.load(
        adUnitId: ad,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
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
                  Interstitialload();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    double weigh = MediaQuery.of(context).size.width;
    double status = MediaQuery.of(context).padding.top;
    double app = kToolbarHeight;
    double total = heigh - status - app;
    return Scaffold(
      backgroundColor: Color(0xFF2C0731),
      body: Column(
        children: [
          Container(
            height: (total / 7),
          ),
          Container(
            height: (total / 7),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 220,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Wordpaly.png"))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: (total / 7),
            alignment: Alignment.center,
            child: Text(
              "Oh No!\nYou lost the Game",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ),
          Container(
              height: (total / 4),
              alignment: Alignment.topCenter,
              child: SvgPicture.asset("assets/sku.svg")),
          Container(
            height: (total / 25),
            alignment: Alignment.topCenter,
            child: Text(
              "Points: NA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: (total / 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Wordplay();
                  },
                ));
              },
              child: Container(
                height: 52,
                width: 208,
                alignment: Alignment.center,
                child: Text(
                  "Play Again",
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(233, 60, 229, 1),
                        Color.fromRGBO(131, 42, 187, 1),
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: (total / 15),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return Wordplay_landing();
                  },));
                  setState(() {
                  });
                },
                child: Text(
                  "Home",
                  style: TextStyle(color: Color.fromRGBO(233, 60, 229, 1)),
                )),
          ),
          SizedBox(height: 50),
          (_bannerAd != null)
              ? Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          )
              : Text("No Banner Ad"),
        ],
      ),
    );
  }
}
