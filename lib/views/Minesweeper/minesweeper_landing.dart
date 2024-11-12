import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:neon/views/Minesweeper/minesweeper_game.dart';

import '../../Ad/google_ad.dart';
import '../../utils/colors.dart';
import '../../utils/global_variable.dart';
import '../../widgets/widgets.dart';

class MineSweeperLanding extends StatelessWidget {
  MineSweeperLanding({super.key});

  final adController = Get.put(AdBannerController());

  RxString _type = lives.value != 0 ? "rev".obs : "fun".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CustomBackButton())),
              SizedBox(
                height: 10,
              ),
              Align(
                child: Image.asset(
                  "assets/neonlogo.png",
                  height: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                child: Image.asset(
                  "assets/mine.png",
                  height: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: lives.value != 0
                    ? () {
                        _type.value = "rev";
                      }
                    : null,
                child: Obx(() {
                  return Container(
                    height: 60,
                    width: 220,
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: _type != 'rev'
                            ? LinearGradient(
                                colors: [Color(0xffd9d9d9), Color(0xffd9d9d9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [Color(0xff27beff), Color(0xff2548ff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "For Rewards",
                        style: TextStyle(
                          color:
                              _type == "rev" ? Color(0xff27beff) : Colors.white,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _type.value = "fun";
                },
                child: Obx(() {
                  return Container(
                    height: 60,
                    width: 220,
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: _type.value != 'fun'
                            ? LinearGradient(
                                colors: [Color(0xffd9d9d9), Color(0xffd9d9d9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [Color(0xff27beff), Color(0xff2548ff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "For Fun",
                        style: TextStyle(
                            color: _type.value == "fun"
                                ? Color(0xff27beff)
                                : Colors.white,
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 60,
              //   width: 220,
              //   decoration: BoxDecoration(
              //     border: GradientBoxBorder(
              //       gradient: LinearGradient(
              //         colors: [Colors.purple, Colors.deepPurple],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //       ),
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "Hard",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontFamily: 'SpaceGrotesk',
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Board(
                                type: _type.value,
                              )));
                },
                child: Container(
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
                  child: Center(
                    child: Text(
                      "Start Match!",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Image.asset(
                      lives.value >= 1
                          ? "assets/heart.png"
                          : "assets/noheart.png",
                      height: 40,
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(() {
                    return Image.asset(
                      lives.value >= 2
                          ? "assets/heart.png"
                          : "assets/noheart.png",
                      height: 40,
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(() {
                    return Image.asset(
                      lives.value >= 3
                          ? "assets/heart.png"
                          : "assets/noheart.png",
                      height: 40,
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: adController.buildBannerAd(),
    );
  }
}
