import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neon/Database/database.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/Minesweeper/minesweeper_game.dart';

import '../../Ad/google_ad.dart';
import '../../utils/global_variable.dart';

// import '../home.dart';

class MineResult extends StatelessWidget {
  final String win;

  MineResult({super.key, required this.win});
  final adController = Get.find<AdBannerController>();
  // final pointController = Get.find<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Obx(() {
                          return Text(
                            lives.value > 0 ? "Play Again!" : "Play For Fun",
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
                SizedBox(
                  height: 10,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
