import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:neon/Database/database.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/widgets/widgets.dart';

import '../../Ad/google_ad.dart';
import '../Suduko/alerts/exit.dart';
import '../Suduko/suduko_matchover.dart';
import 'animation.dart';

class RockPaperGame extends StatefulWidget {
  int totalRound;
  RockPaperGame({super.key, required this.totalRound});

  @override
  State<RockPaperGame> createState() => _RockPaperGameState();
}

class _RockPaperGameState extends State<RockPaperGame> {
  final pointController = Get.find<FirebaseController>();
  final firebaseController = Get.find<FirebaseController>();

  bool _userWin = false;
  bool _computerWin = false;
  bool buttonDisabled = false;
  String? _userChoice;
  String? _computerChoice;
  String? _result;
  bool _isGameStarted = false;
  int _computerScore = 0;
  int userScore = 0;
  int Round = 0;
  String win = "tie";
  bool showInstruction = false;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: ((ad) {
          _interstitialAd = ad;
          setState(() {
            _isInterstitialAdReady = true;
          });
          _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );
        }),
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          setState(() {
            _isInterstitialAdReady = false;
          });
          _interstitialAd.dispose();
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();

    showInstruction = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showInstruction = false;
      });
    });
  }

  void _playGame(String userChoice) {
    // Reset the game if it's the first round
    if (Round == 0) {
      if (widget.totalRound == 3) {
        firebaseController.decreaseLives();
      }

      setState(() {
        userScore = 0;
        _computerScore = 0;
      });
    }

    // Set the user's choice and generate the computer's choice
    setState(() {
      _userChoice = userChoice;
      _computerChoice = _getComputerChoice();
      _isGameStarted = true;
      buttonDisabled = true;
    });
    print(_computerChoice);
    print(_userChoice);

    // Determine the result of the round and update the scores

    // Delay for 2 seconds and reset user choice
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        Round++;

        // Check if the game is over
        if (Round > widget.totalRound - 1) {
          _showResultDialog();
        }
        _getResult();
      });
      _isGameStarted = false;
      _userChoice = null;
      _computerChoice = null;
      _computerWin = false;
      _userWin = false;
      if (Round < widget.totalRound) {
        buttonDisabled = false;
      }
      print("user Score :: $userScore");
      print(_computerScore);
      if (userScore > _computerScore) {
        setState(() {
          win = "win";
        });
      } else if (userScore < _computerScore) {
        setState(() {
          win = "loose";
        });
      } else {
        setState(() {
          win = "tie";
        });
      }
    });
  }

  void restartGame() {
    setState(() {
      Round = 0;
      userScore = 0;
      _computerScore = 0;
      _userChoice = null;
      _computerChoice = null;
      _result = null;
      buttonDisabled = false;
    });
  }

  void _getResult() {
    if (_userChoice == _computerChoice) {
      return draw();
    } else if (_userChoice == 'rock' && _computerChoice == 'scissors' ||
        _userChoice == 'paper' && _computerChoice == 'rock' ||
        _userChoice == 'scissors' && _computerChoice == 'paper') {
      return userWin();
    } else {
      return computerWin();
    }
  }

  void draw() {
    print("its A draw");
  }

  void computerWin() {
    setState(() {
      _computerWin = true;
      _computerScore++;
    });
  }

  void userWin() {
    setState(() {
      _userWin = true;
      userScore++;
    });
  }

  void resetGame() {
    setState(() {
      _computerScore = 0;
      userScore = 0;
      Round = 1;
    });
  }

  void _showResultDialog() {
    Round = widget.totalRound; // userScore = 0;

    Future.delayed(Duration(seconds: 1), () {
      if (win == "win") {
        pointController.updatePointsInFireStore();
      }
      _interstitialAd.show();

      showDialog(
          context: context,
          builder: (context) => SudMatchResult(
                win: win,
                page: "sudoku",
              )).whenComplete(() {
        restartGame();
      });
    });
  }

  String getImageGreen(String choise) {
    switch (choise) {
      case "rock":
        return "assets/rockgamegreen.svg";
      case "paper":
        return "assets/papergamegreen.svg";
      case "scissors":
        return "assets/cisgamegreen.svg";
      default:
        return '';
    }
  }

  String getImagePink(String choise) {
    switch (choise) {
      case "rock":
        return "assets/rockgamepink.svg";
      case "paper":
        return "assets/papergamepink.svg";
      case "scissors":
        return "assets/cisgamepink.svg";
      default:
        return '';
    }
  }

  String _getComputerChoice() {
    final random = Random().nextInt(3);
    switch (random) {
      case 0:
        return 'rock';
      case 1:
        return 'paper';
      case 2:
        return 'scissors';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        _interstitialAd.show();
        showAnimatedDialog<void>(
            animationType: DialogTransitionType.fadeScale,
            barrierDismissible: true,
            duration: const Duration(milliseconds: 350),
            context: context,
            builder: (_) => const AlertExit());

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: showInstruction
            ? Image.asset("assets/Instructions.png")
            : Padding(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        widget.totalRound != 10000
                            ? GestureDetector(
                                onTap: () async {
                                  _interstitialAd.show();
                                  showAnimatedDialog<void>(
                                      animationType:
                                          DialogTransitionType.fadeScale,
                                      barrierDismissible: true,
                                      duration:
                                          const Duration(milliseconds: 350),
                                      context: context,
                                      builder: (_) => const AlertExit());
                                },
                                child: CustomBackButton())
                            : SizedBox(),
                        Spacer(),
                        widget.totalRound != 10000
                            ? Container()
                            : GestureDetector(
                                onTap: () async {
                                  showAnimatedDialog<void>(
                                      animationType:
                                          DialogTransitionType.fadeScale,
                                      barrierDismissible: true,
                                      duration:
                                          const Duration(milliseconds: 350),
                                      context: context,
                                      builder: (_) => const AlertExit());
                                },
                                child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.lightPurple),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Quit",
                                        style: TextStyle(
                                            color: AppColor.textColorGrey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ))),
                      ],
                    ),
                    Container(
                      height: h / 1.688,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: h / 14.06666666667,
                                width: w / 6.5,
                                decoration: BoxDecoration(
                                    color: userScore > _computerScore
                                        ? Colors.transparent
                                        : userScore != _computerScore
                                            ? AppColor.lightPurple
                                            : Colors.transparent,
                                    border:
                                        Border.all(color: AppColor.lightPurple),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "$_computerScore",
                                  style: TextStyle(
                                      color: userScore > _computerScore
                                          ? AppColor.lightPurple
                                          : userScore == _computerScore
                                              ? AppColor.lightPurple
                                              : Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height: h / 14.06666666667,
                                  width: w / 6.5,
                                  decoration: BoxDecoration(
                                      color: userScore < _computerScore
                                          ? Colors.transparent
                                          : userScore != _computerScore
                                              ? AppColor.greenColor
                                              : Colors.transparent,
                                      border: Border.all(
                                          color: AppColor.greenColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "$userScore",
                                    style: TextStyle(
                                        color: userScore < _computerScore
                                            ? AppColor.greenColor
                                            : userScore == _computerScore
                                                ? AppColor.greenColor
                                                : Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )))
                            ],
                          ),
                          Container(
                            height: h / 1.688,
                            width: w / 1.7727272727,
                            child: Stack(
                              children: [
                                !_isGameStarted
                                    ? Align(
                                        alignment: Alignment.topCenter,
                                        child: BlinkingImage(
                                          images: [
                                            "assets/rockgamepink.svg",
                                            "assets/papergamepink.svg",
                                            "assets/cisgamepink.svg",
                                          ],
                                        ),
                                      )
                                    : Positioned(
                                        top: h / 10.55,
                                        left: w / 9.75,
                                        child: SvgPicture.asset(getImagePink(
                                            _computerChoice as String)),
                                      ),
                                !_isGameStarted
                                    ? SizedBox(
                                        height: h / 6.02,
                                      )
                                    : Align(
                                        alignment: Alignment.center,
                                        child: Lottie.asset(
                                            "assets/Crash animation.json")),
                                !_isGameStarted
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: BlinkingImage(
                                          images: [
                                            "assets/rockgamegreen.svg",
                                            "assets/papergamegreen.svg",
                                            "assets/cisgamegreen.svg",
                                          ],
                                        ),
                                      )
                                    : Positioned(
                                        top: h / 3.5166666667,
                                        left: w / 9.75,
                                        child: SvgPicture.asset(getImageGreen(
                                            _userChoice as String)),
                                      ),

                                //   child: SvgPicture.asset(_userChoice == 'rock'
                                //       ? "assets/rockgamegreen.svg"
                                //       : _userChoice == 'paper'
                                //           ? "assets/papergamegreen.svg"
                                //           : "assets/cisgamegreen.svg"),
                              ],
                            ),
                          ),
                          Spacer(),
                          widget.totalRound != 10000
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Round >= 1
                                              ? AppColor.lightPurple
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: AppColor.lightPurple),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Round >= 2
                                              ? AppColor.lightPurple
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: AppColor.lightPurple),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Round >= 3
                                              ? AppColor.lightPurple
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: AppColor.lightPurple),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    widget.totalRound != 3
                                        ? Container(
                                            height: 50,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Round >= 4
                                                    ? AppColor.lightPurple
                                                    : Colors.transparent,
                                                border: Border.all(
                                                    color:
                                                        AppColor.lightPurple),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    widget.totalRound != 3
                                        ? Container(
                                            height: 50,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Round >= 5
                                                    ? AppColor.lightPurple
                                                    : Colors.transparent,
                                                border: Border.all(
                                                    color:
                                                        AppColor.lightPurple),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                )
                              : Container(
                                  height: h / 14.06666666667,
                                  width: w / 6.5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.greenColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "$Round",
                                    style: TextStyle(
                                        color: AppColor.greenColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      height: h / 7.03333333333,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: !buttonDisabled
                                  ? () {
                                      setState(() {
                                        _playGame('rock');
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: w / 3.9,
                                child: SvgPicture.asset(_userChoice == 'rock'
                                    ? "assets/RockGreen.svg"
                                    : "assets/rock.svg"),
                              )),
                          GestureDetector(
                              onTap: !buttonDisabled
                                  ? () {
                                      setState(() {
                                        _playGame('paper');
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: w / 3.9,
                                child: SvgPicture.asset(_userChoice == 'paper'
                                    ? "assets/paperGreen.svg"
                                    : "assets/paper.svg"),
                              )),
                          GestureDetector(
                              onTap: !buttonDisabled
                                  ? () {
                                      setState(() {
                                        _playGame('scissors');
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: w / 3.9,
                                child: SvgPicture.asset(
                                    _userChoice == 'scissors'
                                        ? "assets/cisGreen.svg"
                                        : "assets/cis.svg"),
                              )),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      color: Colors.white,
                      height: 60,
                      width: double.maxFinite,
                      child: Center(child: Text("Banner Ad")),
                    ),
                    SizedBox(
                      height: h / 40,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
