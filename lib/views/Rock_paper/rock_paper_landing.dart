import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/Rock_paper/rock_paper_game.dart';
import 'package:neon/widgets/widgets.dart';

import '../../Ad/google_ad.dart';
import '../../utils/global_variable.dart';

class RockPaperLanding extends StatelessWidget {
  RockPaperLanding({super.key});
  final adController = Get.find<AdBannerController>();
  RxInt rounds =lives.value < 1? 10000.obs: 5.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomBackButton()),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                "assets/neonlogo.png",
                height: 70,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(child: Image.asset("assets/logorps.png")),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Rounds:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("For rewards",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap:lives.value >=1? () {

                          rounds.value = 5;
                        }:null,
                        child: Container(
                            // height: 120,
                            // width: 100,
                            child: rounds.value == 5
                                ? SvgPicture.asset("assets/5.svg")
                                : SvgPicture.asset("assets/5u.svg")),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("For Fun",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          rounds.value = 10000;
                        },
                        child: Container(
                            // height: 120,
                            // width: 100,
                            child: rounds.value == 10000
                                ? Image.asset(
                                    "assets/inf.png",
                                    height: 100,
                                  )
                                : Image.asset(
                                    "assets/infu.png",
                                    height: 90,
                                  )),
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20,
            ),
            Center(
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.white.withOpacity(0.5),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RockPaperGame(
                            totalRound: rounds.value,
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Start Match!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(child: SvgPicture.asset("assets/rpsmain.svg"))
          ]),
        ),
      ),
      bottomNavigationBar: adController.buildBannerAd(),
    );
  }
}
