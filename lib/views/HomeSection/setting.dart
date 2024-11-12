import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neon/authentication/auth_services.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/auth/account.dart';
import 'package:neon/views/auth/login_page.dart';
import 'package:neon/widgets/widgets.dart';

import '../../utils/global_variable.dart';

class Settings extends StatelessWidget {
  FirebaseStorage store = FirebaseStorage.instance;

  Future<String> getDownloadUrl(String path) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(path);
    String downloadUrl = await ref.getDownloadURL();
    print(downloadUrl);

    return downloadUrl;
  }

  RxBool isLoadingUrl = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              // SvgPicture.asset("assets/AVATAR.svg"),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                                color: AppColor.backgroundColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Choose Avatar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/AVATAR.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/AVATAR.png"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/ast.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/ast.png"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/cat.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/cat.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/owl.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/owl.png"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/monkey.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/monkey.png"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        isLoadingUrl.value = true;
                                        final url = await getDownloadUrl(
                                            "avatars/elf.png");
                                        await FirebaseAuth.instance.currentUser!
                                            .updatePhotoURL(url);
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 30,
                                        child: Image.asset("assets/elf.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).whenComplete(() {
                    imageUrl.value =
                        FirebaseAuth.instance.currentUser!.photoURL!;
                    isLoadingUrl.value = false;
                  });
                },
                child: Obx(() {
                  return Stack(
                    children: [
                      // Conditional rendering based on the loading state
                      if (isLoadingUrl.value)
                        Center(
                          child: CircularProgressIndicator(), // Loading icon
                        ),
                      if (!isLoadingUrl.value)
                        Obx(() {
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
                    ],
                  );
                }),
              ),
              // CircleAvatar(
              //   radius: 60,
              // ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${FirebaseAuth.instance.currentUser?.displayName}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${FirebaseAuth.instance.currentUser?.email}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Account();
                    },
                  ));
                },
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColor.lightPurple,
                highlightColor: Colors.transparent,
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.person,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColor.lightPurple,
                highlightColor: Colors.transparent,
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.wallet,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Billing/Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColor.lightPurple,
                highlightColor: Colors.transparent,
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.language_sharp,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Language",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColor.lightPurple,
                highlightColor: Colors.transparent,
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.settings,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColor.lightPurple,
                highlightColor: Colors.transparent,
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.question_answer,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "FAQ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.lightPurple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  AuthServices.signOut();
                },
                child: Container(
                  height: 60,
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
                      "Sign out",
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
