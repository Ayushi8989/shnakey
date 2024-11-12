import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/views/HomeSection/home_page.dart';
import 'package:neon/views/Word_play/wordplay_game.dart';
import 'package:neon/views/Word_play/wordplay_playforfun.dart';


class Wordplay_landing extends StatefulWidget {
  const Wordplay_landing({super.key});

  @override
  State<Wordplay_landing> createState() => _Wordplay_landingState();
}

class _Wordplay_landingState extends State<Wordplay_landing> {
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
    double heigh = MediaQuery.of(context).size.height;
    double weigh = MediaQuery.of(context).size.width;
    double status = MediaQuery.of(context).padding.top;
    double app = kToolbarHeight;
    double total = heigh - status - app;
    return Scaffold(
      backgroundColor: Color(0xFF2C0731),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: (total / 3.3),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: InkWell(
                                onTap:(){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  },));
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/Back.png"))
                                  ),
                                ),
                              )),
                              Expanded(flex: 3,
                                child: Container(
                                  height: 45,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage("assets/Shyaps.png"))),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 80),
                              Expanded(
                                child: Container(
                                  height: 70,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage("assets/NEON.png"))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 80),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/Wordpaly.png"))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Group.png")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: (total / 15),
            //   alignment: Alignment.center,
            //   //child: Text("Shyaps",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            // ),
            // Container(
            //   height: (total / 20),
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.only(bottom: 10),
            //   child: Text(
            //     "Shyaps",
            //     style: TextStyle(
            //         fontSize: 30,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Container(
            //   height: (total / 7),
            //   alignment: Alignment.center,
            //   child: Center(
            //     child: Stack(
            //       children: [
            //         Text(
            //           'NEON',
            //           style: TextStyle(
            //             shadows: [
            //               Shadow(
            //                 offset: Offset(4, 0),
            //                 blurRadius: 3.0,
            //                 color: Color.fromARGB(255, 202, 111, 217),
            //               ),
            //             ],
            //             fontSize: 60,
            //             fontWeight: FontWeight.bold,
            //             foreground: Paint()
            //               ..style = PaintingStyle.stroke
            //               ..strokeWidth = 2
            //               ..color = Color.fromRGBO(233, 61, 229, 1),
            //           ),
            //         ),
            //         const Text(
            //           'NEON',
            //           style: TextStyle(
            //               fontSize: 60,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   height: (total / 30),
            //   alignment: Alignment.topCenter,
            //   margin: EdgeInsets.only(bottom: 10),
            //   child: Center(
            //     child: Stack(
            //       children: [
            //         Text(
            //           'Wordplay',
            //           style: TextStyle(
            //             shadows: [
            //               Shadow(
            //                 offset: Offset(4, 0),
            //                 blurRadius: 3.0,
            //                 color: Color.fromARGB(255, 202, 111, 217),
            //               ),
            //             ],
            //             fontSize: 25,
            //             letterSpacing: 2,
            //             fontWeight: FontWeight.bold,
            //             foreground: Paint()
            //               ..style = PaintingStyle.stroke
            //               ..strokeWidth = 2
            //               ..color = Color.fromRGBO(233, 61, 229, 1),
            //           ),
            //         ),
            //         const Text(
            //           'Wordplay',
            //           style: TextStyle(
            //               fontSize: 25,
            //               letterSpacing: 2,
            //               fontWezight: FontWeight.bold,
            //               color: Colors.white),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            Container(
              height: (total / 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image: AssetImage("assets/Enter authentication.png")),
                      Image(image: AssetImage("assets/Text.png")),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          t = true;
                          setState(() {});
                        },
                        onTapCancel: () {
                          t = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: (t == true)
                                  ? DecorationImage(
                                  image: AssetImage("assets/sumit.png"))
                                  : DecorationImage(
                                  image:
                                  AssetImage("assets/Framefun.png"))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          t = true;
                          setState(() {});
                        },
                        onTapCancel: () {
                          t = false;
                          setState(() {});
                        },
                        child: (t == true)
                            ? Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/winin.png"))),
                        )
                            : Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/win.png")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: (total / 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (t == true) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return fun();
                          },
                        ));
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Wordplay();
                          },
                        ));
                      }
                    },
                    child: Container(
                      height: (total / 3),
                      width: 148,
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child:
                      AutoSizeText(
                        'Start Match',
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
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
                ],
              ),
            ),
            Container(
              height: (total / 4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/noheart.png")),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/noheart.png")),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/noheart.png")),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You dont have enough lives to win rewards!",
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _rewardedAd!.show(onUserEarnedReward:
                              (AdWithoutView ad, RewardItem rewardItem) {
                            // Reward the user for watching an ad.
                            print(rewardItem.amount);
                            print(rewardItem.type);
                          });
                        },
                        child: Text(
                          "Add lives",
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: Color.fromRGBO(233, 60, 229, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}
