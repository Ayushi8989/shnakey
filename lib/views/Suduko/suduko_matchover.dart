import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neon/Database/database.dart';
import 'package:neon/views/Rock_paper/rock_paper_game.dart';
import 'package:neon/views/Suduko/suduko_game.dart';
// import 'package:neon/views/home.dart';
// import 'package:neon/views/home_page.dart';

import '../../utils/colors.dart';
import '../../utils/global_variable.dart';
import '../../widgets/widgets.dart';

class SudMatchResult extends StatelessWidget {
  final String win;
  final String page;
  SudMatchResult({
    super.key,
    required this.win,
    required this.page,
  });
  final FirebaseController firebaseController = Get.find<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                page != "sudoku"
                    ? Align(
                        child: Image.asset(
                          "assets/Suduko2.png",
                          height: 50,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                Text(
                    win == "win"
                        ? "Congratulations!\nYou have won the game "
                        : win == "loose"
                            ? "You have lost the game"
                            : "its A tie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                win == "win"
                    ? SvgPicture.asset("assets/stars.svg")
                    : win == 'loose'
                        ? SvgPicture.asset("assets/sku.svg")
                        : Image.asset(
                            "assets/tie.png",
                            height: 150,
                          ),
                SizedBox(
                  height: 10,
                ),
                Text(win == 'win' ? "Points: 100" : "Points: 0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 20,
                ),
                page == "sudoku"
                    ? SizedBox(
                        height: 32,
                      )
                    : SizedBox(),

                Container(
                  height: 60,
                  width: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: Colors.white.withOpacity(0.5),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        lives.value != 0
                            ? null
                            : firebaseController.decreaseLives();

                        page != "sudoku"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SudokuGame()),
                              )
                            : lives.value == 0
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RockPaperGame(totalRound: 10000)))
                                : Navigator.pop(context);
                      },
                      child: Center(
                        child: Obx(() {
                          return Text(
                            lives.value != 0 ? "Play Again!" : "Play For Fun",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                page != "sudoku"
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                page != "sudoku"
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60,
                          width: 220,
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
                    : SizedBox(height: 0, width: 0),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    height: 60,
                    width: 220,
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
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: AppColor.lightPurple.withOpacity(0.5),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            "Quit",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       "assets/noheart.png",
                //       height: 40,
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Image.asset(
                //       "assets/noheart.png",
                //       height: 40,
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Image.asset(
                //       "assets/noheart.png",
                //       height: 40,
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  color: Colors.white,
                  height: 60,
                  width: double.maxFinite,
                  child: Center(child: Text("Banner Add")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
