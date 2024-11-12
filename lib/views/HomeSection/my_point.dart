import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neon/Ad/google_ad.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/utils/global_variable.dart';

import '../../Database/database.dart';
import '../../Notification/notification.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});
  final rewardedAdController = Get.find<RewardedAdController>();
  final bannerAdController = Get.find<AdBannerController>();
  final pointController = Get.find<FirebaseController>();
  final interController = Get.find<InterstitialAdController>();
  final LocalNotificationController notificationController =
      Get.find<LocalNotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/Top.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "My Points",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Obx(() {
                  return imageUrl != null
                      ? Image.network(
                          imageUrl.value,
                          height: 150,
                        )
                      : Image.asset(
                          "assets/AVATAR.png",
                          height: 140,
                        );
                }),
              ),
              // CircleAvatar(
              //   radius: 60,
              // ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar('Notification Scheduled',
                      'Notification will be shown after 1 hour');
                },
                child: Text(
                  "${FirebaseAuth.instance.currentUser?.displayName}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 170,
                width: 320,
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE93DE5),
                          Color(0xff922DC1),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Points Won",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.asset("assets/Top.png"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Text(
                              points.value.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "SpaceGrotesk",
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Your Wallet",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.asset("assets/rew.png"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Text(
                              "${points.value * 0.001}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "SpaceGrotesk",
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                        ],
                      ),
                    ],
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
                height: 15,
              ),
              // Text("You do not have enough lives to get rewards",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 14,
              //         fontFamily: "SpaceGrotesk",
              //         fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 250,
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
                    onTap: () {
                      if (lives.value == 3) {
                        Get.snackbar("Please Spend Lives First", "",
                            colorText: Colors.white,
                            duration: Duration(seconds: 5));
                      } else {
                        if (adShowCount.value == 3) {
                          Get.snackbar("Come Tomorrow",
                              "You can only View Rewarded ad 3 times a day",
                              colorText: Colors.white,
                              duration: Duration(seconds: 5));
                        } else {
                          rewardedAdController.showRewardedAd();
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    splashColor: AppColor.lightPurple.withOpacity(0.5),
                    highlightColor: Colors.transparent,
                    child: Center(
                      child: Text(
                        "Add Lives!",
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: bannerAdController.buildBannerAd(),
    );
  }
}
