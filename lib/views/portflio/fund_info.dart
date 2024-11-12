import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/colors.dart';

class FundInfo extends StatelessWidget {
  const FundInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            height: 20,
          ),
          Text(
            "Gold Fund",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mode",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Lumpsum+SIP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                    "Category",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Gold",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mode",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Lumpsum+SIP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                    "Category",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Gold",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mode",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Lumpsum+SIP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Breakdown",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Total Investment",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                        Spacer(),
                        Text("\$1,000,000.00",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Total Investment",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                        Spacer(),
                        Text("\$1,000,000.00",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Total Investment",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                        Spacer(),
                        Text("\$1,000,000.00",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Total Investment",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                        Spacer(),
                        Text("\$1,000,000.00",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Total Investment",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                        Spacer(),
                        Text("\$1,000,000.00",
                            style: TextStyle(
                                color: AppColor.textColorGrey,
                                fontSize: 12,
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(builder: (context) => Account()));
                            },
                            child: Container(
                              height: height / 20.06,
                              width: width / 3.40,
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
                                  "Buy Gold!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
