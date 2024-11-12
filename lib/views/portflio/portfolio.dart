import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/auth/account.dart';

import '../../widgets/portfolio_card.dart';
import 'browse_funds.dart';
import 'current_investment.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
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
                    "Portfolio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Total Amount Invested",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "\$1,000,000.00",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "*as of april 2023",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 30,
              ),
              PortElement(
                title1: "Earnings",
                title2: "Returns",
                subtitle1: "\$1,00,000.00",
                subtitle2: "9%",
              ),
              SizedBox(
                height: 15,
              ),
              PortElement(
                title1: "Earnings",
                title2: "Returns",
                subtitle1: "\$1,00,000.00",
                subtitle2: "9%",
              ),
              SizedBox(
                height: 15,
              ),
              PortElement(
                title1: "Earnings",
                title2: "Returns",
                subtitle1: "\$1,00,000.00",
                subtitle2: "9%",
              ),
              SizedBox(
                height: 15,
              ),
              PortElement(
                title1: "Earnings",
                title2: "Returns",
                subtitle1: "\$1,00,000.00",
                subtitle2: "9%",
              ),
              SizedBox(
                height: 15,
              ),
              PortElement(
                title1: "Earnings",
                title2: "Returns",
                subtitle1: "\$1,00,000.00",
                subtitle2: "9%",
              ),
              SizedBox(
                height: 40,
              ),
              Text("Current Investment",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentInvestment()),
                    );
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
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentInvestment()),
                    );
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
              Text(
                "Browse Funds",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              CardCategory(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentInvestment()),
                    );
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrowseFund()),
                  );
                },
                child: Text(
                  "View All Funds",
                  style: TextStyle(
                      color: AppColor.lightPurple,
                      fontSize: 16,
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w100),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PortElement extends StatelessWidget {
  const PortElement({
    super.key,
    this.color,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
  });
  final Color? color;
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              subtitle1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              subtitle2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [],
        )
      ],
    );
  }
}
