import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neon/slidenseek/model/tile.dart';
import 'package:neon/slidenseek/ui/animated_board_widget.dart';
import 'package:neon/slidenseek/ui/home/game_progress.dart';
import 'package:neon/slidenseek/ui/timer_widget.dart';


import 'model/puzzle_solver.dart';
import 'model/puzzle.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<TimerWidgetState> _timerKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  Offset _gyro = Offset.zero;

  AnimationController? _animationController;
  AnimationController? _settingsController;

  bool _showDoors = false;
  final Tween<double> _scaleBoardTween = Tween<double>(begin: 0.0, end: 1.0);
  bool _gyroEnabled = false;
  bool _solving = false;
  Widget _selectedWidget = Image.asset(
    "assets/img/img05.jpeg",
    key: ValueKey('img05'),
    fit: BoxFit.cover,
  );
  late Puzzle _puzzle;
  int _puzzleSize = 4;

  final totalAnim = 8000;
  final tileEnterAnimTile = 700;

  final Tween<double> _rotationXTween = Tween<double>(begin: 2 * pi, end: 0.0);
  final Tween<double> _rotationYTween = Tween<double>(begin: 2 * pi, end: 0.0);

  _initPuzzle({bool puzzleOnly = false}) {
    _puzzle = Puzzle.generate(_puzzleSize, shuffle: true);
    if (!puzzleOnly) {
      _initEnterAnim();
    }
  }

  @override
  void initState() {
    super.initState();
    _initPuzzle();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _settingsController!.forward();
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          Size size = Size(constraints.maxWidth, constraints.maxHeight);
          if (_showDoors) {
            return Center(
              child: _gameLayout(size),
            );
          } else {
            return Center(
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64))),
                    onPressed: () {
                      _initPuzzle(puzzleOnly: true);
                      _settingsController!.reverse();
                      print(_animationController);
                    },
                    label: Text("paly"),
                ));
            // NotStartedControls(
            //       size: size,
            //       puzzleSize: _puzzleSize,
            //       selectedWidget: _selectedWidget,
            //       onWidgetPicked: (newWidget) {
            //         setState(() {
            //           _selectedWidget = newWidget;
            //         });
            //       },
            //       onPuzzleSizePicked: (size) {
            //         setState(() {
            //           _puzzleSize = size;
            //         });
            //       },
            //       onStart: () {
            //         _initPuzzle(puzzleOnly: true);
            //         _settingsController!.reverse();
            //       },
            //     ));
          }
        }),
      ),
    );
  }

  _initEnterAnim() {
    _animationController?.dispose();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _timerKey.currentState?.start();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _settingsController!.forward();
          _showDoors = false;
        });
      }
    });

    _settingsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _settingsController!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          if (_animationController!.isCompleted) {
            _animationController!.reset();
          } else {
            setState(() {
              _showDoors = true;
            });
            _animationController!.forward();
          }
        });
      }
    });
    print(_animationController);
  }

  _solve() async {
    setState(() {
      _solving = true;
    });
    if (kDebugMode) {
      print('solving');
    }
    PuzzleSolver solver = PuzzleSolver();
    var newPuzzle = solver.solve(_puzzle.clone());
    if (kDebugMode) {
      print("new puzzle solved:\n${newPuzzle.toVisualString()}");
    }
    for (int i = max(_puzzle.history.length - 1, 0);
        i < newPuzzle.history.length;
        i++) {
      if (!_solving) {
        break;
      }
      var h = newPuzzle.history[i];
      if (kDebugMode) {
        print(
            "Move $i tile ${_puzzle.tiles.firstWhere((element) => element.currentPosition == h).value}");
      }
      await Future.delayed(const Duration(milliseconds: 450));
      onTileMoved(
        _puzzle.tiles.firstWhere((element) => element.currentPosition == h),
        isAi: true,
      );
    }
    if (_solving) {
      setState(() {
        _solving = false;
      });
    }
  }

  Widget _gameLayout(Size size) {
    final _space = SizedBox(height: size.height / 100);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GameProgress(
            // solving: _solving,
            puzzle: _puzzle,
            size: size,
            listenable: _animationController!,
            selectedWidget: _selectedWidget,
            // showIndicator: _showIndicator,
            timerKey: _timerKey,
            // giveUp: _giveUp,
            // solve: _solve,
            // showIndicatorChanged: () {
            //   setState(() {
            //     _showIndicator = !_showIndicator;
            //   });
            // },
            stoppedSolving: () {
              setState(() {
                _solving = false;
              });
            },
            onWidgetPicked: (newWidget) {
              setState(() {
                _selectedWidget = newWidget;
              });
            },
            gyroEnabled: _gyroEnabled,
            gyroChanged: () {
              setState(() {
                _gyroEnabled = !_gyroEnabled;
              });
            },
          )
        ]),
        Flexible(
          child: _gameContent(size),
        ),
        // StartedControlsButtons(
        //   solving: _solving,
        //   puzzle: _puzzle,
        //   size: size,
        //   listenable: _animationController!.drive(CurveTween(
        //       curve: const Interval(0.5, 1.0, curve: Curves.easeInOut))),
        //   // giveUp: _giveUp,
        //   // solve: _solve,
        //   stoppedSolving: () {
        //     setState(() {
        //       _solving = false;
        //     });
        //   },
        //   gyroEnabled: _gyroEnabled,
        //   gyroChanged: () {
        //     setState(() {
        //       _gyroEnabled = !_gyroEnabled;
        //     });
        //   },
        //   // changeTheme: widget.changeTheme,
        // ),
        // _space,
      ],
    ));
  }

  Widget _gameContent(Size size) {
    return LayoutBuilder(builder: (_, constraints) {
      final contentSize = Size(constraints.maxWidth, constraints.maxHeight);
      final aroundPadding = contentSize.shortestSide / 25;
      final boardContentSize = contentSize.shortestSide - aroundPadding * 2;

      return Padding(
        padding: EdgeInsets.all(aroundPadding),
        child: SizedBox(
          width: boardContentSize,
          height: boardContentSize,
          child: Center(
              child: AnimatedBoardWidget(
            puzzle: _puzzle,
            contentSize: contentSize,
            boardContentSize: Size(boardContentSize, boardContentSize),
            onTileMoved: onTileMoved,
            selectedTileWidget: _selectedWidget,
            // showIndicator: _showIndicator,
            botChild: Container(
              width: boardContentSize,
              height: boardContentSize,
              decoration: BoxDecoration(
                 
                  borderRadius:
                      BorderRadius.circular(contentSize.shortestSide / 30)),
            ),
            rotationXTween: _rotationXTween,
            rotationYTween: _rotationYTween,
            scaleTween: _scaleBoardTween,
            gyroEvent: _gyro,
            animationController: _animationController!,
          )
              //             : StreamBuilder<GyroscopeEvent>(
              //                 initialData: GyroscopeEvent(0, 0, 0),
              //                 stream: gyroscopeEvents
              //                     .where((event) => event.x != 0 || event.y != 0),
              //                 builder: (context, snapshot) {
              //                   _gyro += Offset(degToRadian(snapshot.data?.y ?? 0),
              //                       degToRadian(snapshot.data?.x ?? 0));
              //                   return AnimatedBoardWidget(
              //                       puzzle: _puzzle,
              //                       contentSize: contentSize,
              //                       boardContentSize:
              //                           Size(boardContentSize, boardContentSize),
              //                       onTileMoved: onTileMoved,
              //                       selectedTileWidget: _selectedWidget,
              //                       botChild: Container(
              //                         width: boardContentSize,
              //                         height: boardContentSize,
              //                         decoration: BoxDecoration(
              //                             color: AppColors.boardOuterColor(context)
              //                                 .darker(20),
              //                             borderRadius: BorderRadius.circular(
              //                                 contentSize.shortestSide / 30)),
              //                       ),
              //                       rotationXTween: _rotationXTween,
              //                       rotationYTween: _rotationYTween,
              //                       scaleTween: _scaleBoardTween,
              //                       gyroEvent: _gyro,
              //                       animationController: _animationController!);
              //                 }),
              ),
        ),
      );
    });
  }

  onTileMoved(Tile tile, {bool isAi = false}) {
    if (isAi || !_solving) {
      _puzzle = _puzzle.moveTiles(tile);
      setState(() {});
    }
    // if (_puzzle.isComplete()) {
    //   _timerKey.currentState?.stop();
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     Navigator.pushReplacement(
    //       context,
    //       PageRouteBuilder(
    //         pageBuilder: (context, animation, secondaryAnimation) => WinScreen(
    //           puzzle: _puzzle,
    //           duration:
    //               _timerKey.currentState?.totalDuration ?? const Duration(),
    //           background: _selectedWidget,
    //           // changeTheme: widget.changeTheme,
    //         ),
    //         transitionsBuilder:
    //             (context, animation, secondaryAnimation, child) {
    //           final scaleTween = Tween(begin: 0.0, end: 1.0)
    //               .chain(CurveTween(curve: Curves.elasticOut));
    //           final fadeTween = Tween(begin: 0.0, end: 1.0)
    //               .chain(CurveTween(curve: Curves.easeInOut));
    //           return ScaleTransition(
    //             scale: animation.drive(scaleTween),
    //             child: FadeTransition(
    //               child: child,
    //               opacity: animation.drive(fadeTween),
    //             ),
    //           );
    //         },
    //       ),
    //     );
    //   });
    // }
  }

  // _giveUp() {
  //   setState(() {
  //     _settingsController!.reset();
  //     _animationController?.reverse();
  //     _solving = false;
  //   });
  // }
}
