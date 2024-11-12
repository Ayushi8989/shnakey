import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon/views/Word_play/wordplay_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class fun extends StatefulWidget {
  const fun({super.key});

  @override
  State<fun> createState() => _funState();
}

class _funState extends State<fun> {
  FocusNode _focusNode = FocusNode();
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  Random rng = Random();
  int time = 0;
  bool t = false;
  List option = [];
  List pos = [];
  List<bool> temp = [];
  List<int> randomCharList = [];
  static List ans = [
    "motivative",
    "subindexes",
    "undertaxes",
    "inflecting",
    "sepulchers",
    "invertible",
    "promptbook",
    "librarian",
    "positivism",
    "overedits"
  ];
  List<bool> border = [];
  int cur_level = 0;
  List userans = [];
  List<bool> hintArray = [];
  List<bool> cursor = [for (int i = 0; i <= 10; i++) false];
  int a = 0;
  static List r = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
  ];
  void initState() {
    loadAd();
    Interstitialload();
    VideoloadAd();
    print("CurLevel:${cur_level}");
    timer();
    word_list();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Keyboard dismisses when the TextField loses focus
        _dismissKeyboard();
      }
    });
    setState(() {});
    temp = List.filled(5, false);
    hintArray = List.filled(15, false);
  }

  void _dismissKeyboard() {
    // Dismiss the keyboard
    FocusScope.of(context).unfocus();
  }

  SharedPreferences? preferences;
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
  Future level() async {
    userans = List.filled(ans.length, "panding");
    level().then((value) {
      cur_level = preferences!.getInt("level") ?? 1;
      print("CurLevel:${cur_level}");
      for (int i = 0; i < cur_level; i++) {
        userans[i] = preferences!.getString("levelStauts$i");
      }
    });
    // Data Store
    preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  timer() async {
    for (int i = 100; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        time = i;
      });
    }
  }

  word_list() {
    r.shuffle();
    option = List.filled(14, "");
    pos = List.filled(14, "");
    userans = List.filled(ans[cur_level].toString().length, "");
    for (int i = 0; i < 4; i++) {
      Random rng = Random();
      int randomIndex = rng.nextInt(ans[cur_level].toString().length);
      userans[randomIndex] = ans[cur_level].toString()[randomIndex];
      randomCharList.add(randomIndex);
    }
    bool dataAdded = false;
    for (int i = 0; i < userans.length; i++) {
      if (userans[i] == "" && !dataAdded) {
        a = i;
        print("Data S = : ${a}");
        dataAdded = true;
      }
    }
    for (int i = 0; i < ans[cur_level].toString().length; i++) {
      option[i] = ans[cur_level].toString()[i];
      cursor[i] = true;
    }
    for (int i = ans[cur_level].toString().length; i < 14; i++) {
      option[i] = r[i];
    }
    option.shuffle();
  }

  show_popup() {
    print("Alert");
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            height: 155,
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exit Game",
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk', color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  "Are you sure you want to exit the game ? ",
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk-Medium.ttf',
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Wordplay_landing();
                            },
                          ));
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk', color: Colors.white),
                        )),
                    SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk', color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF2C0732),
        );
      },
    );
  }

  hint() {
    for (int i = 1; i < 2; i++) {
      int randomIndex = rng.nextInt(ans[cur_level].toString().length);
      userans[randomIndex] = ans[cur_level].toString()[randomIndex];

      hintArray[randomIndex] = true;
      setState(() {});
    }
  }

  get_http() async {
    var url = Uri.parse('https://random-word-api.herokuapp.com/word');
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final maindata = jsonDecode(response.body);
        ans = maindata['word'];
        for (int i = 0; i <= 10; i++) {
          t = true;
          setState(() {});
        }
      } else {
        print(response.statusCode);
      }
    } on Exception catch (e) {
      print("Error" + e.toString());
    }
    setState(() {});
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
              height: (total / 10),
              width: total,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        width: 220,
                        alignment: Alignment.center,
                        child: Center(
                          child: Stack(
                            children: [
                              Text(
                                'Wordplay',
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(4, 0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 202, 111, 217),
                                    ),
                                  ],
                                  fontSize: 40,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Color.fromRGBO(233, 61, 229, 1),
                                ),
                              ),
                              const Text(
                                'Wordplay',
                                style: TextStyle(
                                    fontSize: 40,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: (total / 8),
              width: total,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("Hello Print");
                        word_list();
                        setState(() {});
                      },
                      child: Container(
                        height: 56,
                        width: 90,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color.fromRGBO(88, 88, 87, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Shuffle",
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _rewardedAd!.show(onUserEarnedReward:
                            (AdWithoutView ad, RewardItem rewardItem) {
                          // Reward the user for watching an ad.
                          print(rewardItem.amount);
                          print(rewardItem.type);
                        });
                        print("Hello Print");
                        hint();
                        setState(() {});
                      },
                      child: Container(
                        height: 56,
                        width: 90,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color.fromRGBO(88, 88, 87, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Hint",
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              height: (total / 20),
              width: total,
              margin: EdgeInsets.only(right: 25, left: 25),
              child: StepProgressIndicator(
                totalSteps: 10,
                currentStep: cur_level,
                selectedColor: Color.fromRGBO(37, 72, 255, 1),
                unselectedColor: Colors.white,
              ),
            ),
            Container(
              height: (total / 3),
              width: total,
              child: Center(
                child: Wrap(
                  children: List.generate(
                    ans[cur_level].toString().length,
                        (index) => InkWell(
                      onTap: () {
                        option[pos[index]] == userans[index];
                        userans[index] = "";
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(11),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Color.fromRGBO(78, 50, 77, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${userans[index]}",
                              style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  color: hintArray[index] == true
                                      ? Colors.green
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            (a == index)
                                ? Divider(
                              color: Colors.white,
                              indent: 12,
                              endIndent: 12,
                              thickness: 2,
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: (total / 7),
              width: total,
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  return (option[index] != "")
                      ? GestureDetector(
                    onTapUp: (details) {
                      temp[index] = false;
                      setState(() {});
                    },
                    onTapDown: (details) {
                      temp[index] = true;
                      setState(() {});
                    },
                    onTapCancel: () {
                      temp[index] = false;
                      setState(() {});
                    },
                    onTap: () {
                      // cursor==true;
                      bool dataAdded = false;
                      for (int i = 0; i < userans.length; i++) {
                        if (userans[i] == "" && !dataAdded) {
                          userans[i] = option[index];
                          a = i;
                          checkRandomIndex();
                          i == userans.length + 13;
                          option.shuffle();
                          pos[i] = index;
                          setState(() {});
                          dataAdded = true;
                        }
                      }
                      // setState(() {});
                    },
                    child: Container(
                      height: 10,
                      width: 10,
                      //color: Colors.yellow,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "${option[index]}",
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(37, 72, 255, 1),
                                offset: Offset(5, 4),
                                blurRadius: 3),
                          ],
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          color: (temp[index] == true)
                              ? Color.fromRGBO(131, 42, 187, 1)
                              : Color.fromRGBO(29, 1, 28, 1),
                          border: Border.all(
                              color: Color.fromRGBO(37, 72, 255, 1),
                              width: 2)),
                    ),
                  )
                      : Text("");
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: (total / 5),
              width: total,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          show_popup();
                        },
                        child: Container(
                          height: 41,
                          width: 88,
                          child: Text(
                            "Quit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: Color.fromRGBO(88, 88, 87, 1)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("Cur_Level : ${cur_level}");
                          print(
                              "Words:${userans.toString().replaceAll(' ,', '').replaceAll(' ', '').replaceAll(',', '').replaceAll('[', '').replaceAll(']', '')}.");
                          print("Ans :${ans[cur_level]}.");
                          if (ans[cur_level] ==
                              userans
                                  .toString()
                                  .replaceAll(' ,', '')
                                  .replaceAll(' ', '')
                                  .replaceAll(',', '')
                                  .replaceAll('[', '')
                                  .replaceAll(']', '')) {
                            preferences?.setString(
                                "levelStauts$cur_level", "win");
                            preferences?.setInt("level", cur_level);
                            cur_level++;
                            if (cur_level >= 10) {
                              // If the score reaches 10 or more, navigate to the win page.
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return gameover(time);
                              //   },
                              // ));
                            }
                            print("Win : ${ans[cur_level]}");
                            setState(() {});
                            word_list();
                          } else {
                            print("Worng");
                          }
                        },
                        child: Container(
                          height: 52,
                          width: 148,
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
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
                      InkWell(
                        onTap: () {
                          _interstitialAd!.show();
                          preferences?.setString(
                              "levelStauts$cur_level", "win");
                          preferences?.setInt("level", cur_level);
                          cur_level++;
                          word_list();
                          setState(() {});
                          if (cur_level >= 10) {
                            // If the score reaches 10 or more, navigate to the win page.
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return gameover(time);
                            //   },
                            // ));
                          }
                          print("Skip : ${cur_level}");
                          print("${word_list()}");
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Skip"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromRGBO(131, 42, 187, 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            action: SnackBarAction(
                              label: "Submit",
                              onPressed: () {},
                            ),
                          ));
                          setState(() {});
                        },
                        child: Container(
                          height: 41,
                          width: 88,
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: Color.fromRGBO(88, 88, 87, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkRandomIndex() {
    if (randomCharList.contains(a)) {
      a++;
      checkRandomIndex();
    }
  }
}
