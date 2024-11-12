import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neon/Database/database.dart';
import 'dart:math';
import 'dart:async';

import 'package:neon/utils/colors.dart';

import '../../Ad/google_ad.dart';
import '../../utils/global_variable.dart';
import '../Suduko/alerts/exit.dart';
import 'minesweeper_result.dart';

enum TileState { covered, blown, open, flagged, revealed }

class Board extends StatefulWidget {
  final String type;
  Board({required this.type});

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  final adController = Get.find<AdBannerController>();
  final firebaseController = Get.find<FirebaseController>();

  final pointController = Get.find<FirebaseController>();
  final int rows = 21;
  final int cols = 12;
  int numOfMines = 55;
  bool firstClick = true;
  String won = "loose";

  List<List<TileState>>? uiState;
  List<List<bool>>? tiles;

  bool alive = true;
  bool wonGame = false;
  int minesFound = 0;
  bool flaggingEnabled = false;
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

  void resetBoard() {
    alive = true;
    wonGame = false;
    minesFound = 0;
    firstClick = true;

    uiState = new List<List<TileState>>.generate(rows, (row) {
      return new List<TileState>.filled(cols, TileState.covered);
    });

    tiles = new List<List<bool>>.generate(rows, (row) {
      return new List<bool>.filled(cols, false);
    });

    // Do not generate mines here, it will be done in the first click
  }

  int generateRandomNumber(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  @override
  void initState() {
    initInterstitialAd();

    resetBoard();
    numOfMines = generateRandomNumber(50, 60);
    showInstruction = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showInstruction = false;
      });
    });

    super.initState();
  }

  Widget buildBoard() {
    bool hasCoveredCell = false;
    List<Row> boardRow = <Row>[];
    for (int y = 0; y < rows; y++) {
      List<Widget> rowChildren = <Widget>[];
      for (int x = 0; x < cols; x++) {
        TileState state = uiState![y][x];
        int count = mineCount(x, y);

        if (!alive) {
          if (state != TileState.blown && state != TileState.flagged) {
            state = tiles![y][x] ? TileState.revealed : state;
          }
        }

        if (state == TileState.covered || state == TileState.flagged) {
          rowChildren.add(GestureDetector(
            // onLongPress: () {
            //   flag(x, y);
            // },
            onTap: () {
              if (flaggingEnabled) {
                flag(x, y);
              } else {
                if (state == TileState.covered) probe(x, y);
              }
            },
            child: Listener(
                child: CoveredMineTile(
              bomb: tiles![y][x],
              flagged: state == TileState.flagged,
              posX: x,
              posY: y,
              alive: alive,
              // cols: cols,
            )),
          ));
          if (state == TileState.covered) {
            hasCoveredCell = true;
          }
        } else {
          rowChildren.add(OpenMineTile(
            color: tiles![y][x] && state != TileState.blown
                ? Colors.transparent
                : Colors.white,
            state: state,
            count: count,
            isClicked: tiles![y][x] && state != TileState.blown,
          ));
        }
      }
      boardRow.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
        key: ValueKey<int>(y),
      ));
    }
    if (!hasCoveredCell) {
      if ((minesFound == numOfMines) && alive) {
        setState(() {
          won = "win";
        });
        Future.delayed(Duration(seconds: 3), () {
          _interstitialAd.show();
        });
      }
    }

    return Container(
      color: AppColor.backgroundColor,
      child: Column(
        children: boardRow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
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
            ? Center(
                child: Image.asset(
                  "assets/Instructionsmsp.png",
                  height: h,
                  width: w,
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: h / 11.06666666667, left: w / 19.5, right: w / 19.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: Container(
                            height: h / 14.06666666667,
                            width: w / 6,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$numOfMines ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset("assets/tabler_bomb.png",
                                    height: h / 15, width: w / 17),
                              ],
                            ),
                          ),
                        ),
                        !firstClick
                            ? Container(
                                width: 150,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          flaggingEnabled = !flaggingEnabled;
                                        });
                                      },
                                      child: Container(
                                        height: h / 14.06666666667,
                                        width: w / 6,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Image.asset(
                                            flaggingEnabled
                                                ? "assets/shovel.png"
                                                : "assets/shovelo.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          flaggingEnabled = !flaggingEnabled;
                                        });
                                      },
                                      child: Container(
                                        height: h / 14.06666666667,
                                        width: w / 6,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "${numOfMines - minesFound}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Image.asset(
                                                flaggingEnabled
                                                    ? "assets/flaga.png"
                                                    : "assets/flago.png",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: h / 40,
                    ),
                    Expanded(
                      child: Center(
                        child: buildBoard(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void resetBoardExcept(int clickedX, int clickedY, bool isReset) {
    // Clear the board
    // tiles = new List<List<bool>>.generate(rows, (row) {
    //   return new List<bool>.filled(cols, false);
    // });
    int minesFoundHere = 0;

    // Calculate the boundaries to leave 2 boxes from each side
    // int startX = clickedX - 2;
    // int startY = clickedY - 2;
    // int endX = clickedX + 2;
    // int endY = clickedY + 2;

    // Generate mines for the entire board except the clicked tile
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        while (minesFoundHere < numOfMines) {
          int row = Random().nextInt(rows);
          int col = Random().nextInt(cols);
          if (row == clickedY && col == clickedX) {
            // Skip the clicked tile
            continue;
          }

          int startRow = clickedY - 1;
          int endRow = clickedY + 1;
          int startCol = clickedX - 1;
          int endCol = clickedX + 1;

          // Adjust the range to ensure it stays within the board boundaries
          if (startRow < 0) startRow = 0;
          if (endRow >= rows) endRow = rows - 1;
          if (startCol < 0) startCol = 0;
          if (endCol >= cols) endCol = cols - 1;

          if (row >= startRow &&
              row <= endRow &&
              col >= startCol &&
              col <= endCol) {
            // Skip the tiles within the surrounding range
            continue;
          }

          if (!tiles![row][col]) {
            // Place a mine
            tiles![row][col] = true;
            minesFoundHere++;
            mineCount(row, col);
            print("Mine Found :: $minesFoundHere");
          }
        }
      }
    }

// Update the neighboring mine counts
  }

  void probe(int x, int y) {
    if (!alive) return;
    if (uiState![y][x] == TileState.flagged) return;

    setState(() {
      if (firstClick) {
        // Generate mines except for the clicked tile
        if (widget.type != "fun") {
          firebaseController.decreaseLives();
        }
        resetBoardExcept(x, y, true);
        print("Resetting board :: ${x} , ${y}");
        firstClick = false;
      }

      if (tiles![y][x]) {
        uiState![y][x] = TileState.blown;
        alive = false;
        Future.delayed(Duration(seconds: 3), () {
          _interstitialAd.show();

          showDialog(
            context: context,
            builder: (context) {
              return MineResult(win: won);
            },
          ).whenComplete(() {
            setState(() {
              numOfMines = generateRandomNumber(50, 60);

              resetBoard();
            });
          });
        });
      } else {
        open(x, y);
      }
    });
  }

  void open(int x, int y) {
    if (!inBoard(x, y)) return;
    if (uiState![y][x] == TileState.open) return;

    if (uiState![y][x] == TileState.flagged) {
      return; // Skip opening flagged tiles
    }

    uiState![y][x] = TileState.open;
    if (mineCount(x, y) > 0) return;

    open(x - 1, y);
    open(x + 1, y);
    open(x, y - 1);
    open(x, y + 1);
    open(x - 1, y - 1);
    open(x + 1, y + 1);
    open(x + 1, y - 1);
    open(x - 1, y + 1);
  }

  void flag(int x, int y) {
    if (!alive) return;
    if (minesFound >= numOfMines && uiState![y][x] != TileState.flagged) {
      // Check if the maximum number of flags is reached
      showFlagsReachedSnackbar();
      // Show the snackbar
      return;
    }

    setState(() {
      if (uiState![y][x] == TileState.flagged) {
        uiState![y][x] = TileState.covered;
        minesFound--;
      } else {
        uiState![y][x] = TileState.flagged;
        minesFound++;
      }
    });
  }

  void showFlagsReachedSnackbar() {
    final snackBar = SnackBar(
      content: Text(
        'You have reached the maximum number of flags.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool hasBomb(int x, int y) {
    // Assuming you have a 2D array called "tiles" representing the game board
    return tiles![y][x];
  }

  int mineCount(int x, int y) {
    int count = 0;
    count += bombs(x - 1, y);
    count += bombs(x + 1, y);
    count += bombs(x, y - 1);
    count += bombs(x, y + 1);
    count += bombs(x - 1, y - 1);
    count += bombs(x + 1, y + 1);
    count += bombs(x + 1, y - 1);
    count += bombs(x - 1, y + 1);
    return count;
  }

  int bombs(int x, int y) => inBoard(x, y) && tiles![y][x] ? 1 : 0;
  bool inBoard(int x, int y) => x >= 0 && x < cols && y >= 0 && y < rows;
}

Widget buildTile(Widget child, BuildContext context) {
  final double h = MediaQuery.of(context).size.height;
  final double w = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.all(1.0),
    height: h / 30.0,
    width: w / 13.6,
    color: AppColor.backgroundColor,
    child: child,
  );
}

Widget buildInnerTile(Widget child, BuildContext context) {
  final double h = MediaQuery.of(context).size.height;
  final double w = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.all(1.0),
    margin: EdgeInsets.all(2.0),
    height: 22.0,
    width: 22.0,
    child: child,
  );
}

class CoveredMineTile extends StatelessWidget {
  final bool flagged;
  final int? posX;
  final int? posY;
  final bool bomb;
  final bool alive;

  CoveredMineTile(
      {required this.flagged,
      this.posX,
      this.posY,
      required this.bomb,
      required this.alive});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final bool isEvenPosition = (posX! + posY!) % 2 == 0;
    final Color tileColor =
        isEvenPosition ? Color(0xff3c203b) : Color(0xff4E324D);

    Widget content;
    if (flagged) {
      content = Image.asset(
        !flagged
            ? "assets/flaga.png"
            : !alive
                ? bomb
                    ? "assets/Bomb under flag PNG.png"
                    : "assets/flaga.png"
                : "assets/flaga.png",
        height: h / 42.2,
        width: w / 19.5,
      );
    } else {
      content =
          SizedBox(); // Replace with the image or widget you want to display for a covered mine without a flag
    }
// "assets/flag.png"
    Widget innerTile = Container(
      padding: EdgeInsets.all(1.0),
      height: h / 38.3636363636,
      width: w / 17.7272727273,
      color: !flagged
          ? tileColor
          : !alive
              ? bomb
                  ? Color(0xff161616)
                  : tileColor
              : tileColor,
      child: content,
    );

    return buildTile(innerTile, context);
  }
}

class OpenMineTile extends StatelessWidget {
  final TileState state;
  final int count;
  final bool isClicked;
  final Color? color;

  OpenMineTile({
    required this.state,
    required this.count,
    required this.isClicked,
    required this.color,
  });

  final List textColor = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.cyan,
    Colors.amber,
    Colors.brown,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    Widget text = SizedBox();

    if (state == TileState.open) {
      if (count != 0) {
        text = RichText(
          text: TextSpan(
            text: '$count',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor[count - 1],
            ),
          ),
          textAlign: TextAlign.center,
        );
      }
    } else {
      text = Container(
        color: color,
        child: Image(
            image: isClicked
                ? AssetImage("assets/tabler_bomb.png")
                : AssetImage("assets/blast.png")),
      );
    }

    return buildTile(buildInnerTile(text, context), context);
  }
}
