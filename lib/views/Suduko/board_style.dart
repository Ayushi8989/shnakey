import 'package:flutter/material.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/Suduko/suduko_game.dart';

Color emptyColor(bool gameOver) =>
    gameOver ? Colors.green : AppColor.darkPurple;

Color buttonColor(
  int k,
  int i,
) {
  Color color;
  color = AppColor.backgroundColor;

  return color;
}

// double buttonSize() {
//   double size = 50;
//   if (SuDukoGameState.platform.contains('android') ||
//       SuDukoGameState.platform.contains('ios')) {
//     size = 38;
//   }
//   return size;
// }

// double buttonFontSize() {
//   double size = 20;
//   if (SuDukoGameState.platform.contains('android') ||
//       SuDukoGameState.platform.contains('ios')) {
//     size = 16;
//   }
//   return size;
// }

BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
  if (k == 0 && i == 0) {
    return const BorderRadius.only(topLeft: Radius.circular(5));
  } else if (k == 0 && i == 8) {
    return const BorderRadius.only(topRight: Radius.circular(5));
  } else if (k == 8 && i == 0) {
    return const BorderRadius.only(bottomLeft: Radius.circular(5));
  } else if (k == 8 && i == 8) {
    return const BorderRadius.only(bottomRight: Radius.circular(5));
  }
  return BorderRadius.circular(0);
}
