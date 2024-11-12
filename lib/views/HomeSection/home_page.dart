import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/state_manager.dart';

import 'package:neon/utils/colors.dart';
import 'package:neon/utils/global_variable.dart';
import 'package:neon/views/Minesweeper/minesweeper_game.dart';
import 'package:neon/views/Minesweeper/minesweeper_landing.dart';
import 'package:neon/views/Rock_paper/rock_paper_game.dart';
import 'package:neon/views/Rock_paper/rock_paper_landing.dart';
import 'package:neon/views/Suduko/suduko_boarding.dart';
import 'package:neon/views/Suduko/suduko_game.dart';
import 'package:neon/views/Word_play/wordplay_boarding.dart';

import 'package:neon/widgets/bottomnavigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(FirebaseAuth.instance.currentUser!.uid);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
              top: height / 14.06, left: width / 19.5, right: width / 19.5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      // onTap: (){
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => Settings()));
                      // },
                      child: Obx(() {
                        return imageUrl.value != null
                            ? Image.network(
                                imageUrl.value,
                                height: height / 18,
                              )
                            : Image.asset(
                                "assets/AVATAR.png",
                                height: height / 18,
                              );
                      }),
                    ),
                    SizedBox(
                      width: width / 39,
                    ),
                    Text(
                      "Hi ${FirebaseAuth.instance.currentUser?.displayName}!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: height / 25,
                ),
                Container(
                    height: height / 4.82,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColor.lightPurple,
                          AppColor.darkPurple
                        ]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 19.5, vertical: height / 44),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Portfolio Value",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "SpaceGrotesk"),
                              ),
                              GlowingOverscrollIndicator(
                                axisDirection: AxisDirection.down,
                                color: Colors.white,
                                child: Text("USD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              blurRadius: 2,
                                              offset: Offset(1, 1))
                                        ],
                                        fontFamily: "SpaceGrotesk",
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$543.65",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "SpaceGrotesk",
                                shadows: [
                                  Shadow(
                                      color: Colors.white,
                                      blurRadius: 2,
                                      offset: Offset(1, 1)),
                                  Shadow(
                                      color: Colors.white,
                                      blurRadius: 2,
                                      offset: Offset(-1, 0))
                                ],
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Monthly Investement",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "SpaceGrotesk"),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$543.65",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "SpaceGrotesk",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                height: height / 28.13,
                                width: width / 6.5,
                                decoration: BoxDecoration(
                                    color: AppColor.lightPurple,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  "13%",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "SpaceGrotesk",
                                      fontWeight: FontWeight.bold),
                                )),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: height / 28.13,
                ),
                Text(
                  "Recently Played",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context, rootNavigator: true).push(
                        //     MaterialPageRoute(builder: (_) => SanmillApp()));
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/SLOT.png")),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (_) => SudukoFront()));
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/SUDOKU.png")),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Games",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) => MineSweeperLanding()));
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/mineNew.png")),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) => RockPaperLanding()));
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/RPS.png")),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) {
                          return Wordplay_landing();
                        },));
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/word.png")),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
