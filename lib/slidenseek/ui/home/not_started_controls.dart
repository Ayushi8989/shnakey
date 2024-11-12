import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../model/puzzle.dart';
import '../settings/background_widget_picker.dart';
import '../settings/puzzle_size_picker.dart';

class NotStartedControls extends StatelessWidget {
  final Size size;
  final Widget selectedWidget;
  final int puzzleSize;
  final Function(int) onPuzzleSizePicked;
  final Function(Widget) onWidgetPicked;
  final VoidCallback onStart;

  const NotStartedControls({
    Key? key,
    required this.size,
    required this.puzzleSize,
    required this.onPuzzleSizePicked,
    required this.onWidgetPicked,
    required this.onStart,
    required this.selectedWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: size.height / 40);
    return ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64))),
        onPressed: onStart,
        label: Text("play"));
  }
}
//   Widget _selectedWidget(BuildContext context) {
//     return LayoutBuilder(builder: (_, constraints) {
//       return Center(
//           child: SizedBox(
//         width: min(constraints.maxWidth, constraints.maxHeight),
//         height: min(constraints.maxWidth, constraints.maxHeight),
//         child: Padding(
//           child: BoardContent(
//               showIndicator: false,
//               contentSize: Size(
//                   min(constraints.maxWidth, constraints.maxHeight),
//                   min(constraints.maxWidth, constraints.maxHeight)),
//               puzzle: Puzzle.generate(puzzleSize, shuffle: false),
//               backgroundWidget: selectedWidget,
//               onTileMoved: (_) {},
//               xTilt: 0,
//               yTilt: 0),
//           padding: EdgeInsets.all(
//               min(constraints.maxWidth, constraints.maxHeight) / 15),
//         ),
//       ));
//     });
//   }
// }
