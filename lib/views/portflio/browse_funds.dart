import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:neon/utils/colors.dart';

import 'package:neon/widgets/portfolio_card.dart';

import 'fund_info.dart';

class BrowseFund extends StatelessWidget {
  const BrowseFund({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
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
                    "Browse Funds",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
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
              Row(
                children: [
                  Text(
                    "Browse Funds",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FundInfo()));
                  },
                  color: Colors.cyan,
                  height: height,
                  width: width,
                  title: "Silver Find Title",
                  amount_invested: "\$1,000,000.00",
                  category: "Gold",
                  Earnings: "\$1,000,0.00",
                  Growth: "9%",
                  Mode: "Growth"),
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FundInfo()));
                  },
                  color: Colors.yellowAccent,
                  height: height,
                  width: width,
                  title: "GOLD by ZXY",
                  amount_invested: "\$1,000,0.00",
                  category: "Gold",
                  Earnings: "\$1,000,0.00",
                  Growth: "9%",
                  Mode: "Growth"),
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FundInfo()));
                  },
                  color: Colors.cyan,
                  height: height,
                  width: width,
                  title: "Silver Find Title",
                  amount_invested: "\$1,000,0.00",
                  category: "Gold",
                  Earnings: "\$1,000,0.00",
                  Growth: "9%",
                  Mode: "Growth"),
            ],
          ),
        ),
      ),
    );
  }
}
