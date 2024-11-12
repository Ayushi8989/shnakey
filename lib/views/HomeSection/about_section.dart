import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:neon/utils/colors.dart';

// import '../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: width / 19.5, right: width / 19.5, top: height / 14.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/iconabt.png"),
                  ),
                  SizedBox(
                    width: width / 19.5,
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("Search")],
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: GradientOutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          colors: [AppColor.lightPurple, AppColor.darkPurple]),
                      width: 2),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Top Questions",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE93DE5),
                          Color(0xff922DC1),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: width / 19.5),
                    title: Text(
                      "How to set up Gold SIP?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Steps for setting up an SIP in GOLD funds so you can start investing right away answer text answer text answer answer text answer. Steps for setting up an SIP in GOLD funds text answer answer text answer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE93DE5),
                          Color(0xff922DC1),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(
                      "How to set up Gold SIP?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Steps for setting up an SIP in GOLD funds so you can start investing right away answer text answer text answer answer text answer. Steps for setting up an SIP in GOLD funds text answer answer text answer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE93DE5),
                          Color(0xff922DC1),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(
                      "How to set up Gold SIP?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Steps for setting up an SIP in GOLD funds so you can start investing right away answer text answer text answer answer text answer. Steps for setting up an SIP in GOLD funds text answer answer text answer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "SpaceGrotesk",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
