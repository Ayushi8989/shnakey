import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neon/slidenseek/ui/timer_widget.dart';
import '../../model/puzzle.dart';

class GameProgress extends AnimatedWidget {
  final Puzzle puzzle;
  final Size size;
  final Widget selectedWidget;
  final VoidCallback stoppedSolving;
  final Function(Widget) onWidgetPicked;
  final GlobalKey timerKey;
  final bool gyroEnabled;
  final VoidCallback gyroChanged;

  const GameProgress({
    Key? key,
    required Listenable listenable,
    required this.puzzle,
    required this.size,
    required this.selectedWidget,
    required this.stoppedSolving,
    required this.onWidgetPicked,
    required this.timerKey,
    required this.gyroEnabled,
    required this.gyroChanged,
  }) : super(key: key, listenable: listenable);

  Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final timer = TimerWidget(
      key: timerKey,
    );
    final xTilt = Tween<double>(begin: -2 * pi, end: 0.0)
        .chain(CurveTween(curve: const ElasticOutCurve(0.4)))
        .evaluate(_animation);
    final yTilt = Tween<double>(begin: -2 * pi, end: 0.0)
        .chain(CurveTween(curve: const ElasticOutCurve(0.4)))
        .evaluate(_animation);
    final scale = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn))
        .evaluate(_animation);
    return Column(children: [
      _counter(context, screenSize),
      SizedBox(width: size.shortestSide / 60),
      timer,
    ]);
  }

  Widget _counter(BuildContext context, Size screenSize) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: "${puzzle.history.length}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ));
  }
  //   return Transform.scale(
  //     child: ZWidgetWrapper(
  //       midChild: RepaintBoundary(
  //           child: RepaintBoundary(
  //         child: StartedControls(
  //           size: size,
  //           puzzle: puzzle,
  //           onWidgetPicked: (_) {},
  //           // showIndicator: false,
  //           selectedWidget: const SizedBox(),
  //           // showIndicatorChanged: showIndicatorChanged,
  //           // solving: solving,
  //           timerKey: null,
  //           stoppedSolving: stoppedSolving,
  //           // solv/e: solve,
  //           // giveUp: () {},
  //           gyroEnabled: false,
  //           gyroChanged: () {},
  //           isBuildForPerspective: true,
  //         ),
  //       )),
  //       topChild: RepaintBoundary(
  //         child: StartedControls(
  //           size: size,
  //           puzzle: puzzle,
  //           onWidgetPicked: onWidgetPicked,
  //           selectedWidget: selectedWidget,
  //           timerKey: timerKey,
  //           stoppedSolving: stoppedSolving,
  //           gyroEnabled: gyroEnabled,
  //           gyroChanged: gyroChanged,
  //         ),
  //       ),
  //       rotationX: xTilt,
  //       rotationY: yTilt,
  //       depth: 20,
  //       direction: ZDirection.forwards,
  //       layers: 11,
  //       alignment: Alignment.center,
  //     ),
  //     scale: scale,
  //   );
  // }
}
