import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:neon/Database/database.dart';
import 'package:neon/Snakey/loss.dart';
import 'package:neon/Snakey/pregame.dart';
import 'package:neon/Snakey/win.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../utils/colors.dart';

List<int> snakePosition = [42, 62, 82, 102];
final firebaseController = Get.find<FirebaseController>();
var randomNumber = Random();
int gridColumns = 20;
int gridRows = (500 / gridColumns).ceil();
int centerRow = gridRows ~/ 1.5;
int centerColumn = gridColumns ~/ 2;

int food = centerRow * gridColumns + centerColumn;
var speed = 400;
bool playing = false;
var direction = 'down';
Timer? _timer;
bool endGame = false;
bool showStar = false;
bool showSkull = false;
bool showInstruction = false;

class SnakeGameFun extends StatefulWidget {
  const SnakeGameFun({super.key, required this.type});
  final type;
  @override
  SnakeGameFunState createState() => SnakeGameFunState();
}

class SnakeGameFunState extends State<SnakeGameFun> {
  GameState gameState = GameState(
    snakePosition: [42, 62, 82, 102],
    food: centerRow * gridColumns + centerColumn,
    speed: 400,
    playing: false,
    paused: false,
    currentLevel: 0,
  );
  @override
  void initState() {
    super.initState();
    showInstruction = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showInstruction = false;
      });
    });
    setState(() {
      playing = false;
    });
    startGame();
    resetGame();
    loadAd();
    // firebaseController.decreaseLives();
    VideoloadAd();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    saveAppState();
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

  int cur_level = 0;
  @override
  Widget build(BuildContext context) {
    int columns = 20;
    int numberOfSquares = 500;

    return WillPopScope(
      onWillPop: () async {
        saveAppState();
        togglePause();
        showDialog(
          context: context, barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Pused'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you want to exit the game?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    playing = false;
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const SnakeyPreGame();
                      },
                    ));
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    togglePause();
                  },
                ),
              ],
            );
          },
        );

        return true;
      },
      child: showInstruction
          ? Center(
              child: Image.asset(
                "assets/snakeyinstructions.png",
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
              ),
            )
          : Scaffold(
              backgroundColor: const Color(0xFF1D011C),
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child:
                                  Image.asset("assets/snakey.png", height: 60),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/snakeyinstructions.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            icon: Image.asset(
                              'assets/gg_info.png',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (direction != 'up' && details.delta.dy > 0) {
                              direction = 'down';
                            } else if (direction != 'down' &&
                                details.delta.dy < 0) {
                              if (direction != 'down') {
                                direction = 'up';
                              }
                            }
                          },
                          onHorizontalDragUpdate: (details) {
                            if (direction != 'left' && details.delta.dx > 0) {
                              direction = 'right';
                            } else if (direction != 'right' &&
                                details.delta.dx < 0) {
                              if (direction != 'right') {
                                direction = 'left';
                              }
                            }
                          },
                          child: GridView.builder(
                            itemCount: numberOfSquares,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              if (index < 20 ||
                                  index >= numberOfSquares - 20 ||
                                  index % gridColumns == 0 ||
                                  (index + 1) % gridColumns == 0) {
                                return Container(
                                  padding: const EdgeInsets.all(1),
                                  child: ClipRRect(
                                    child: Container(
                                      color: const Color(0xFF4E324D),
                                    ),
                                  ),
                                );
                              }
                              if (snakePosition.contains(index)) {
                                if (index == snakePosition.last) {
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                        child: Container(
                                          color: AppColor.lightPurple,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          color: AppColor.darkPurple,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                              if (index == food) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/star.json',
                                    height: 25,
                                    width: 25,

                                  ),
                                );
                              } else {
                                return Container(
                                  padding: const EdgeInsets.all(1),
                                  child: ClipRRect(
                                    child: Container(
                                      color: const Color(0xFF3C203B),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // if (showStar)
                  //   Positioned(
                  //     top: 320,
                  //     left: 0,
                  //     right: 0,
                  //     child: Center(
                  //       child: Lottie.asset(
                  //         'assets/star.json',
                  //         height: 200,
                  //         width: 200,
                  //       ),
                  //     ),
                  //   ),
                  if (showSkull)
                    Positioned(
                      top: 230,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Lottie.asset('assets/skull.json',
                            height: 400, width: 400),
                      ),
                    ),
                  (_bannerAd != null)
                      ? Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: MaterialButton(
                            onPressed: () => {},
                            child: SafeArea(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: AdWidget(ad: _bannerAd!),
                              ),
                            ),
                          ),
                        )
                      : const Text("No Banner Ad"),
                ],
              ),
            ),
    );
  }

  void saveAppState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gameState', json.encode(gameState.toJson()));
  }

  void restoreAppState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gameStateJson = prefs.getString('gameState');

    if (gameStateJson != null) {
      setState(() {
        gameState = GameState.fromJson(json.decode(gameStateJson));
      });
    }
  }

  void togglePause() {
    setState(() {
      gameState.paused = !gameState.paused;
    });

    if (gameState.paused) {
      // If the game is paused, save the game state
      saveGameState();
    } else {
      // If the game is unpaused, restore the game state
      restoreGameState();
      startGame();
    }
  }

  void saveGameState() {
    gameState = GameState(
      snakePosition: snakePosition.toList(),
      food: food,
      speed: speed,
      playing: playing,
      paused: true,
      currentLevel: cur_level,
    );
  }

  void restoreGameState() {
    setState(() {
      snakePosition = gameState.snakePosition;
      food = gameState.food;
      speed = gameState.speed;
      playing = gameState.playing;
      cur_level = gameState.currentLevel;
    });
  }

  void startGame() {
    if (gameState.paused) return;
    setState(() {
      gameState.paused = false;
      playing = true;
    });
    endGame = false;
    // snakePosition = [42, 62, 82, 102];
    var duration = Duration(milliseconds: speed);

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(duration, (Timer t) {
      if (!playing || endGame) {
        t.cancel();
        if (endGame) {
          startGame();
          return;
        }
        return;
      }

      updateSnake();
      firebaseController.decreaseLives();
      if (gameOver()) {
        if (gameOver()) {
          t.cancel();
          showSkull = true;
          showStar = false;
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              showSkull = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: () async {
                        playing = false;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SnakeyPreGame();
                            },
                          ),
                        );
                        return true;
                      },
                      child: SnakeyLoss(
                        points: (snakePosition.length - 4).toString(),
                      ),
                    );
                  },
                ),
              );
            });
          });
        }
      }
    });
  }

  bool gameOver() {
    if (!gameState.paused) {
      final int headPosition = snakePosition.last;
      // Check for collisions with the snake's own body
      for (int i = 0; i < snakePosition.length - 1; i++) {
        if (headPosition == snakePosition[i]) {
          setState(() {
            playing = false;
          });
          return true;
        }
      }
      return false;
    }

    return false;
  }

  generateNewFood() {
    int newFoodIndex;
    do {
      newFoodIndex = randomNumber.nextInt(500);
    } while (snakePosition.contains(newFoodIndex) ||
        newFoodIndex % gridColumns == 0 ||
        (newFoodIndex + 1) % gridColumns == 0 ||
        newFoodIndex < gridColumns ||
        newFoodIndex >= (gridRows - 1) * gridColumns);

    food = newFoodIndex;
  }

  updateSnake() {
    if (!gameState.paused) {
      setState(() {
        switch (direction) {
          case 'down':
            if (snakePosition.last > 480) {
              snakePosition.add(snakePosition.last + 20 - 500);
            } else {
              snakePosition.add(snakePosition.last + 20);
            }
            break;
          case 'up':
            if (snakePosition.last < 20) {
              snakePosition.add(snakePosition.last - 20 + 500);
            } else {
              snakePosition.add(snakePosition.last - 20);
            }
            break;
          case 'left':
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last - 1 + 20);
            } else {
              snakePosition.add(snakePosition.last - 1);
            }
            break;
          case 'right':
            if ((snakePosition.last + 1) % 20 == 0) {
              snakePosition.add(snakePosition.last + 1 - 20);
            } else {
              snakePosition.add(snakePosition.last + 1);
            }
            break;
          default:
        }
        if (snakePosition.last == food) {
          showStar = true;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              showStar = false;
            });
          });
          cur_level++;
          speed -= 40;
          generateNewFood();
        } else {
          snakePosition.removeAt(0);
        }
      });
    }
  }

  void resetGame() {
    setState(() {
      playing = true;
      endGame = false;
      direction = 'down';
      cur_level = 0;
      speed = 400;
      snakePosition = [42, 62, 82, 102];
      generateNewFood();
      showStar = false;
      showSkull = false;
    });
  }
}

class GameState {
  List<int> snakePosition;
  int food;
  int speed;
  bool playing;
  bool paused;
  int currentLevel;

  GameState({
    required this.snakePosition,
    required this.food,
    required this.speed,
    required this.playing,
    required this.paused,
    required this.currentLevel,
  });

  // Convert the GameState object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'snakePosition': snakePosition,
      'food': food,
      'speed': speed,
      'playing': playing,
      'paused': paused,
      'currentLevel': currentLevel,
    };
  }

  // Create a GameState object from a JSON Map
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      snakePosition: List<int>.from(json['snakePosition']),
      food: json['food'],
      speed: json['speed'],
      playing: json['playing'],
      paused: json['paused'],
      currentLevel: json['currentLevel'],
    );
  }
}
