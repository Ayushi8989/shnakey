import 'package:flutter/material.dart';
import 'package:neon/utils/colors.dart';

class AlertGameOver extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  const AlertGameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColor.darkPurple,
      title: Text(
        'Game Over',
        style: TextStyle(color: AppColor.lightPurple),
      ),
      content: Text(
        'You successfully solved the Sudoku',
        style: TextStyle(color: AppColor.lightPurple),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColor.lightPurple)),
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: const Text('Restart Game'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColor.lightPurple)),
          onPressed: () {
            Navigator.pop(context);
            newGame = true;
          },
          child: const Text('New Game'),
        ),
      ],
    );
  }
}
