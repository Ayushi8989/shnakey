import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/Snakey/fun.dart';
import 'package:neon/Snakey/snake.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/utils/global_variable.dart';

class SnakeyPreGame extends StatefulWidget {
  const SnakeyPreGame({super.key});

  @override
  State<SnakeyPreGame> createState() => _SnakeyPreGameState();
}

// final GlobalKey<_SnakeGameState> snakeGameKey = GlobalKey<_SnakeGameState>();
class _SnakeyPreGameState extends State<SnakeyPreGame> {
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
  bool isForFun = false;

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

  void selectOption(bool funOption) {
    setState(() {
      isForFun = funOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    double weigh = MediaQuery.of(context).size.width;
    double status = MediaQuery.of(context).padding.top;
    double app = kToolbarHeight;
    double total = heigh - status - app;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2C0731),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const SnakeyPreGame();
                  },
                ));
              },
              child: Container(
                height: 50,
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/Back.png"))),
              ),
            ),
          ),
        ),
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
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const SizedBox(width: 80),
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/Shyaps.png"))),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 80),
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/NEON.png"))),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const SizedBox(width: 80),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/snakey.png"),
                                            scale: 2)),
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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Group.png")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 196.0,
                    height: 56.0,
                    decoration: isForFun
                        ? BoxDecoration(
                            border: Border.all(color: AppColor.lightPurple),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          )
                        : BoxDecoration(
                            border: Border.all(color: const Color(0xFF585857)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                    child: OutlinedButton(
                      onPressed: () {
                        selectOption(true);
                      },
                      child: Text(
                        'For Fun',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color:
                                isForFun ? AppColor.lightPurple : colorWhite),
                      ),
                    ),
                  ),
                  Container(
                    width: 196.0,
                    height: 56.0,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: isForFun
                        ? BoxDecoration(
                            border: Border.all(color: const Color(0xFF585857)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          )
                        : BoxDecoration(
                            border: Border.all(color: AppColor.lightPurple),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                    child: OutlinedButton(
                      onPressed: () {
                        selectOption(false);
                      },
                      child: Text(
                        'For Rewards',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color:
                                isForFun ? colorWhite : AppColor.lightPurple),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (isForFun) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        print(isForFun);
                        return SnakeGame(type: isForFun);
                      },
                    ));
                  } else {
                    // lives.value != 0?

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        print(isForFun);
                        return SnakeGame(type: isForFun);
                      },
                    ));
                  }
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
                    'Start Match',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: (total / 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Image.asset(
                            lives.value >= 1
                                ? "assets/heart.png"
                                : "assets/noheart.png",
                            height: 40,
                          );
                        }),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(() {
                          return Image.asset(
                            lives.value >= 2
                                ? "assets/heart.png"
                                : "assets/noheart.png",
                            height: 40,
                          );
                        }),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(() {
                          return Image.asset(
                            lives.value >= 3
                                ? "assets/heart.png"
                                : "assets/noheart.png",
                            height: 40,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        lives.value == 0
                            ? const Text(
                                "You dont have enough lives to win rewards!",
                                style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text('')
                      ],
                    ),
                    const SizedBox(height: 5),
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
                          child: const Text(
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
