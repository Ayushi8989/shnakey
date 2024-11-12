import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neon/slidenseek/model/puzzle.dart';
import 'package:neon/slidenseek/model/tile.dart';
import 'package:neon/slidenseek/ui/board_content.dart';
import 'package:zwidget/zwidget.dart';

class AnimatedBoardWidget extends AnimatedWidget {
  final Puzzle puzzle;
  final Size contentSize;
  final Size boardContentSize;
  final Widget botChild;
  final Widget? topChild;
  final Widget selectedTileWidget;
  final Function(Tile) onTileMoved;
  final Tween<double> rotationXTween;
  final Tween<double> rotationYTween;
  final Tween<double> scaleTween;
  final Offset gyroEvent;
  final bool showIndicator;

  const AnimatedBoardWidget({
    Key? key,
    required this.puzzle,
    required this.contentSize,
    required this.botChild,
    this.topChild,
    required this.selectedTileWidget,
    required this.onTileMoved,
    required this.rotationXTween,
    required this.rotationYTween,
    required this.scaleTween,
    required Listenable animationController,
    required this.boardContentSize,
    this.gyroEvent = Offset.zero,
    this.showIndicator = false,
  }) : super(key: key, listenable: animationController);

  // Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: BoardContent(
          puzzle: puzzle,
          contentSize: boardContentSize,
          backgroundWidget: selectedTileWidget,
          onTileMoved: onTileMoved,
          showIndicator: false,
        ),
      ),
    );
  }
}
