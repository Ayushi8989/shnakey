import 'package:flutter/material.dart';
import 'package:neon/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertAbout extends StatelessWidget {
  static const String authorURL = "https://www.github.com/VarunS2002/";
  static const String releasesURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/releases/";
  static const String sourceURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/";
  static const String licenseURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/blob/master/LICENSE";

  const AlertAbout({Key? key}) : super(key: key);

  openURL(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColor.darkPurple,
      title: Center(
        child: Text(
          'About',
          style: TextStyle(color: AppColor.lightPurple),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '   Sudoku',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Version: ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              //     InkWell(
              //       onTap: () => openURL(releasesURL),
              //       child: Text(
              //         '${MyApp.versionNumber} ',
              //         style: TextStyle(
              //             color: AppColor.lightPurple,
              //             fontFamily: 'roboto',
              //             fontSize: 15),
              //       ),
              //     ),
              //     Text(
              //       HomePageState.platform,
              //       style: TextStyle(
              //           color: Styles.foregroundColor,
              //           fontFamily: 'roboto',
              //           fontSize: 15),
              //     ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Author: ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () => openURL(authorURL),
                child: Text(
                  'VarunS2002',
                  style: TextStyle(
                      color: AppColor.darkPurple,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'License: ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () => openURL(licenseURL),
                child: Text(
                  'GNU GPLv3',
                  style: TextStyle(
                      color: AppColor.lightPurple,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: AppColor.lightPurple,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => openURL(sourceURL),
                child: Text(
                  'Source Code',
                  style: TextStyle(
                      color: AppColor.darkPurple,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
