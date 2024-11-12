import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neon/Database/database.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/Suduko/board_style.dart';
import 'package:neon/views/Suduko/suduko_matchover.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import '../../utils/global_variable.dart';
import '../../widgets/widgets.dart';

import 'alerts/exit.dart';
import 'alerts/game_over.dart';
import 'alerts/numbers.dart';

class SudokuGame extends StatefulWidget {
  @override
  _SudokuGameState createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> with WidgetsBindingObserver {
  final firebaseController = Get.find<FirebaseController>();
  bool firstRun = true;
  bool finish = false;
  int points = 0;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  bool isFABDisabled = false;
  bool buttonDisableOnFinish = false;
  bool isSolnShown = false;
  String win = "loose";
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String? currentDifficultyLevel;
  Duration _duration = Duration(minutes: 15);
  bool _showAddTimeButton = false;
  Timer? _timer;
  int? onPauseTime;
  static const String onPauseTimeKey = 'onPauseTime';
  static const String timerDurationLeftKey = 'timerDurationLeft';
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

  void restartGame() {
    setState(() {
      game = copyGrid(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  int selectedIndex = -1;
  int selectedk = 0;
  List<Widget> createButtons(context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }

    List<SizedBox> buttonList = List<SizedBox>.filled(9, const SizedBox());
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        key: Key('grid-button-$k-$i'),
        width: width / 10.26,
        height: height / 22.21,
        child: TextButton(
          onPressed: !buttonDisableOnFinish
              ? isButtonDisabled || gameCopy[k][i] != 0
                  ? null
                  : () {
                      setState(() {
                        selectedIndex = i;
                        selectedk = k;
                      });
                      showAnimatedDialog<void>(
                              animationType: DialogTransitionType.fade,
                              barrierDismissible: true,
                              duration: const Duration(milliseconds: 300),
                              context: context,
                              builder: (_) => const AlertNumbersState())
                          .whenComplete(() {
                        setState(() {
                          selectedIndex = -1;
                          selectedk = -1;
                        });
                        callback([k, i], AlertNumbersState.number);
                        AlertNumbersState.number = null;
                        calculatePoints(i, k);
                      });
                    }
              : null,
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                selectedIndex == i && selectedk == k
                    ? AppColor.lightPurple
                    : AppColor.backgroundColor),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return gameCopy[k][i] == 0
                    ? game[k][i] == gameSolved[k][i]
                        ? finish
                            ? Colors.green
                            : Colors.white
                        : finish
                            ? Colors.red
                            : Colors.white
                    : finish
                        ? Colors.white
                        : AppColor.lightPurple;
              }
              return game[k][i] == gameSolved[k][i]
                  ? finish
                      ? Colors.green
                      : Colors.white
                  : finish
                      ? Colors.red
                      : Colors.white;
            }),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: buttonEdgeRadius(k, i),
            )),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  static Future<void> saveAppState(
      int onPauseTime, int timerDurationLeft) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(onPauseTimeKey, onPauseTime);
    await prefs.setInt(timerDurationLeftKey, timerDurationLeft);
  }

  static Future<void> restoreAppState(
      void Function(int?, int?) callback) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? onPauseTime = prefs.getInt(onPauseTimeKey);
    int? timerDurationLeft = prefs.getInt(timerDurationLeftKey);
    callback(onPauseTime, timerDurationLeft);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);

          // Check if remaining duration is less than or equal to 2 minutes
          if (_duration.inSeconds <= 120) {
            _showAddTimeButton = true;
          } else if (_duration.inSeconds > 10) {
            _showAddTimeButton = false;
          }
        } else {
          _stopTimer();
        }
        print(_duration.inSeconds);
      });
    });
  }

  void _addTime() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _duration += Duration(minutes: 5);
                      _showAddTimeButton = false;
                      _startTimer();
                    });
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.cancel),
                  ),
                ),
                Center(child: Text('Advertisemnt goes here')),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final onPauseTime = DateTime.now().millisecondsSinceEpoch;
      final timerDurationLeft = _duration.inSeconds;
      print("duration left $timerDurationLeft");
      _stopTimer();

      saveAppState(onPauseTime, _duration.inSeconds);
    } else if (state == AppLifecycleState.resumed) {
      restoreAppState((onPauseTime, timerDurationLeft) {
        if (onPauseTime != null && timerDurationLeft != null) {
          final onResumeTime = DateTime.now().millisecondsSinceEpoch;
          final timeDifference = (onResumeTime - onPauseTime) / 1000;

          // Calculate time difference in seconds

          if (timerDurationLeft > timeDifference) {
            // Timer was still running
            final newDuration = timerDurationLeft - timeDifference;
            final newdurationInSec = newDuration;
            final newDurationInSec = newdurationInSec;
            print("new duration $newDuration");

            Duration duration = Duration(seconds: newDurationInSec.toInt());
            print(newDurationInSec.toInt());
            setState(() {
              _duration = duration;
            });

            _startTimer();
            // Start or resume the timer with the new duration
          } else {
            // Timer has already completed
            setState(() {
              _duration = Duration(seconds: 0);
              _stopTimer();
            });
          }
        }
      });
    }
  }

  // Rest of your code

  void _resetTimer() {
    setState(() {
      _duration = Duration(minutes: 15); // Replace with your desired duration
    });
    _stopTimer();
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    if (_duration.inSeconds == 0) {
      setState(() {
        finish = true;
        gameOver = true;
        isButtonDisabled =
            !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
        _showAddTimeButton = false;
      });
      lives.value--;
      _resetTimer();
      showDialog(
          context: context,
          builder: (context) => SudMatchResult(
                win: win,
                page: "sudoku",
              ));
    }
  }

  @override
  void initState() {
    super.initState();
    initInterstitialAd();

    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == null) {
        currentDifficultyLevel = 'hard';
        setPrefs('currentDifficultyLevel');
      }

      newGame(currentDifficultyLevel!);
      WidgetsBinding.instance.addObserver(this);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: AlertDialog(
              backgroundColor: AppColor.backgroundColor,
              title: Text("Instructions",
                  style: TextStyle(color: Color(0xffd9d9d9))),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text("Click on the button to open the numbers menu",
                        style: TextStyle(color: Color(0xffd9d9d9))),
                    SizedBox(height: 10),
                    Text("To erase a number long press on it",
                        style: TextStyle(color: Color(0xffd9d9d9))),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok', style: TextStyle(color: Color(0xffd9d9d9))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }).whenComplete(() {
      _startTimer();
    });
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentDifficultyLevel = prefs.getString('currentDifficultyLevel');
    });
  }

  setPrefs(String property) async {
    final prefs = await SharedPreferences.getInstance();
    if (property == 'currentDifficultyLevel') {
      prefs.setString('currentDifficultyLevel', currentDifficultyLevel!);
    }
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        // The puzzle is solved correctly

        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        win = "win";
        firebaseController.updatePointsInFireStore();

        Timer(const Duration(milliseconds: 500), () {
          showAnimatedDialog<void>(
            animationType: DialogTransitionType.fadeScale,
            barrierDismissible: true,
            duration: const Duration(milliseconds: 350),
            context: context,
            builder: (_) => const AlertGameOver(),
          ).whenComplete(() {
            if (AlertGameOver.newGame) {
              newGame();
              AlertGameOver.newGame = false;
            } else if (AlertGameOver.restartGame) {
              restartGame();
              AlertGameOver.restartGame = false;
            }
          });
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  static Future<List<List<List<int>>>> getNewGame(
      [String difficulty = 'hard']) async {
    int emptySquares = 54;

    SudokuGenerator generator = SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }

  static List<List<int>> copyGrid(List<List<int>> grid) {
    return grid.map((row) => [...row]).toList();
  }

  void setGame(int mode, [String difficulty = 'hard']) async {
    if (mode == 1) {
      game = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameSolved = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
    } else {
      gameList = await getNewGame(difficulty);
      game = gameList[0];
      gameCopy = copyGrid(game);
      gameSolved = gameList[1];
    }
  }

  void calculatePoints(int i, int k) {
    if (gameCopy[k][i] == 0 && game[k][i] == gameSolved[k][i]) {
      points += 1;
    } else {}
    print(points);
  }

  void showSolution() {
    setState(() {
      game = copyGrid(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame([String difficulty = 'hard']) {
    setState(() {
      isFABDisabled = !isFABDisabled;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        setGame(2, difficulty);
        isButtonDisabled =
            isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
        gameOver = false;
        isFABDisabled = !isFABDisabled;
      });
    });
  }

  Row oneRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(context),
    );
  }

  List<Row> createRows() {
    List<Row> rowList = List<Row>.generate(9, (i) => oneRow());
    return rowList;
  }

  void callback(List<int> index, int? number) {
    setState(() {
      if (number == null) {
        return;
      } else if (number == 0) {
        game[index[0]][index[1]] = number;
      } else {
        game[index[0]][index[1]] = number;
      }
    });
    checkResult();
  }

  @override
  void dispose() {
    _stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');
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
            body: Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            _resetTimer();
                            showAnimatedDialog<void>(
                                animationType: DialogTransitionType.fadeScale,
                                barrierDismissible: true,
                                duration: const Duration(milliseconds: 350),
                                context: context,
                                builder: (_) => const AlertExit());
                          },
                          child: CustomBackButton()),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/Suduko2.png",
                          height: 40,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: AlertDialog(
                                  backgroundColor: AppColor.backgroundColor,
                                  title: Text("Instructions",
                                      style:
                                          TextStyle(color: Color(0xffd9d9d9))),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        SizedBox(height: 10),
                                        Text(
                                            "Click on the button to open the numbers menu",
                                            style: TextStyle(
                                                color: Color(0xffd9d9d9))),
                                        SizedBox(height: 10),
                                        Text(
                                            "To erase a number long press on it",
                                            style: TextStyle(
                                                color: Color(0xffd9d9d9))),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Ok',
                                          style: TextStyle(
                                              color: Color(0xffd9d9d9))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                            backgroundColor: AppColor.lightPurple,
                            child: Icon(Icons.info)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Builder(builder: (builder) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: createRows(),
                      ),
                    );
                  }),
                  //AlertNumbersState(),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: h / 14.06666666667,
                        width: w / 3.25,
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [Colors.purple, Colors.deepPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '$minutes:$seconds',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      !finish
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  finish = true;
                                  buttonDisableOnFinish = true;
                                  isButtonDisabled = !isButtonDisabled
                                      ? !isButtonDisabled
                                      : isButtonDisabled;
                                });

                                _stopTimer();
                                _interstitialAd.show();
                              },
                              child: Container(
                                height: h / 14.06666666667,
                                width: w / 3.25,
                                decoration: BoxDecoration(
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.purple,
                                        Colors.deepPurple
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Finish",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SpaceGrotesk',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : !isSolnShown
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSolnShown = true;
                                    });

                                    Timer(const Duration(milliseconds: 200),
                                        () => showSolution());
                                  },
                                  child: Container(
                                    height: h / 14.06666666667,
                                    width: w / 3.25,
                                    decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple,
                                            Colors.deepPurple
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Solution",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    finish = false;

                                    _resetTimer();
                                    isSolnShown = false;
                                    buttonDisableOnFinish = false;

                                    Timer(const Duration(milliseconds: 200),
                                        () => newGame(currentDifficultyLevel!));

                                    _startTimer();
                                  },
                                  child: Container(
                                    height: h / 14.06666666667,
                                    width: w / 3.25,
                                    decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple,
                                            Colors.deepPurple
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "New game",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _showAddTimeButton
                      ? GestureDetector(
                          onTap: () {
                            _stopTimer();
                            _addTime();
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.deepPurple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Watch ad to add 5 min",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SpaceGrotesk',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),

                  Spacer(),
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: double.maxFinite,
                    child: Center(child: Text("Banner Ad")),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
    // floatingActionButton: ));
  }
}
