library my_prj.globals;

import 'dart:developer' as rahul;
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'colors.dart';
// import 'package:nexus/authentication/api/email_password_auth.dart';
// import 'package:nexus/authentication/api/google_login.dart';
// import 'package:nexus/authentication/welcome_page.dart';
// import 'package:nexus/util/colors.dart';
// import 'package:nexus/util/constants.dart';
// import 'package:nexus/util/text_styles.dart';
// import 'package:shimmer/shimmer.dart';

// import 'api/global_api.dart';
// import 'booking/api.dart';
// import 'authentication/welcome_page.dart';
// import 'main.dart';

//=========================Variables============================================
RxString imageUrl = FirebaseAuth.instance.currentUser!.photoURL!.obs;
RxInt lives = 0.obs;
RxInt adShowCount = 0.obs;

void showSnackbar(context, String message, color, [int duration = 4000]) {
  try {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  } catch (e) {
    customPrint("SnackBar Error :: $e");
  }
  final snackBar = SnackBar(
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    // margin: const EdgeInsets.all(constants.defaultPadding),
    backgroundColor: color,
    duration: Duration(milliseconds: duration),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// void showSnackbarWithAction(context) {
//   try {
//     // Scaffold.of(context).hideCurrentSnackBar();
//   } catch (e) {
//     //
//   }

//   final snackBar = SnackBar(
//     elevation: 6.0,
//     behavior: SnackBarBehavior.floating,
//     margin: const EdgeInsets.all(constants.defaultPadding),
//     content: const Text('Login to access this feature'),
//     action: SnackBarAction(
//       label: 'Login',
//       textColor: colorBorder,
//       onPressed: () {
//         // nextPage(context, const LoginPage(back: true));
//       },
//     ),
//   );

//   // Find the ScaffoldMessenger in the widget tree
//   // and use it to show a SnackBar.
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

Future? nextPage(context, Widget page) {
  return Get.to(page, transition: Transition.rightToLeft);
}

void nextPageFade(context, Widget page) {
  Get.to(page, transition: Transition.fade);
}

int limitValue(int length, int limit) {
  if (length > limit) {
    return limit;
  }
  return length;
}

// void openDrawerPage(context) {
//   Navigator.push(
//       context,
//       PageTransition(
//           type: PageTransitionType.leftToRight,
//           child: const UserProfilePage()));
// }

List<String> timeTitleList = [
  "All day",
  "Morning",
  "Afternoon",
  "Evening",
  "Night"
];
List<String> timeList = [
  "06:00 - 24:00",
  "06:00 - 12:00",
  "12:00 - 16:00",
  "16:00 - 20:00",
  "20:00 - 24:00"
];

int getStaticCount(int? data, [int maxCount = 4]) {
  if (data == null) {
    return maxCount;
  }
  if (data > 0) {
    return data;
  }
  return maxCount;
}

bool getStaticCountCondition(int? data) {
  if (data == null) {
    return true;
  }
  if (data > 0) {
    return false;
  }
  return true;
}

// Widget showShimmer(BuildContext context, [double height = 155]) {
//   return Shimmer.fromColors(
//     baseColor: colorWhite,
//     highlightColor: colorDisable,
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: constants.borderRadius,
//         color: colorDisable,
//       ),
//       margin: const EdgeInsets.all(constants.defaultPadding),
//       height: height,
//     ),
//   );
// }

// bool checkFilter(int index) {
//   final data = BookingApi.turfsModel!.data![index].turfDetails;
//   final dataCourt = BookingApi.turfsModel!.data![index].courtsDetails;
//   if (numberFromString(GlobalApi.distanceValue.toStringAsFixed(0)) >
//       numberFromString(data.distance)) {
//     for (int i = 0; i < dataCourt.length; i++) {
//       if (GlobalApi.selectedDuration != "NA" &&
//           numberFromString(GlobalApi.selectedDuration).toStringAsFixed(0) ==
//               dataCourt[i].duration) {
//         if (GlobalApi.selectedType == "NA") {
//           return true;
//         } else if (dataCourt[i].description.contains(GlobalApi.selectedType)) {
//           return true;
//         }
//       }
//
//       if (GlobalApi.selectedType != "NA" &&
//           dataCourt[i].description.contains(GlobalApi.selectedType)) {
//         if (GlobalApi.selectedDuration == "NA") {
//           return true;
//         } else if (numberFromString(GlobalApi.selectedDuration)
//                 .toStringAsFixed(0) ==
//             dataCourt[i].duration) {
//           customPrint("selectedType :: ${GlobalApi.selectedType}");
//           return true;
//         }
//       }
//
//       if (GlobalApi.selectedType == "NA" &&
//           GlobalApi.selectedDuration == "NA") {
//         return true;
//       }
//     }
//   }
//   return false;
// }

int numberFromString(String text) {
  return int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

// Widget loadingWidget([String msgTitle = "No Data Found.", int delay = 3]) {
//   return Center(
//     child: FutureBuilder(
//         future: Future.delayed(Duration(seconds: delay)),
//         builder: (c, s) => s.connectionState == ConnectionState.done
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "images/empty.png",
//                     height: 122,
//                   ),
//                   SizedBox(
//                     height: constants.defaultPadding,
//                   ),
//                   Text(
//                     msgTitle,
//                     style: textStyle.subHeadingColorDark
//                         .copyWith(color: colorHeadingText),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               )
//             : const CircularProgressIndicator()),
//   );
// }

List<String> dynamicToStatic(List projectClimate) {
  List<String> aa = [];
  for (int i = 0; i < projectClimate.length; i++) {
    aa.add(projectClimate[i].toString().trim());
  }
  return aa;
}

bool validateField(context, TextEditingController controller,
    [int validateLength = 0, String fieldType = "default"]) {
  if (controller.text.length > validateLength) {
    switch (fieldType) {
      case "default":
        return true;
        break;
      case "phone":
        if (controller.text.length == 10) {
          return true;
        }
        showSnackbar(context, "Phone number should be 10 digits", Colors.red);

        break;
      case "email":
        if (controller.text.contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
          return true;
        }
        showSnackbar(context, "Provide correct email address", Colors.red);
        break;
      case "password":
        if (controller.text.length > 8) {
          return true;
        }
        showSnackbar(context, "Password should be 8 digits", Colors.red);
        break;
    }
  } else {
    showSnackbar(context, "Field Can't be empty...", Colors.red);
    return false;
  }
  return false;
}

Widget titleTextField(String s, TextEditingController nameController,
    [bool enable = true, final keyBoard = TextInputType.text]) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            s,
            style: const TextStyle(fontSize: 18, color: colorDark),
          ),
        ),
      ),
      Container(
        height: 46,
        decoration: BoxDecoration(
            // color: global.colorLight,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(left: 18, right: 18, top: 6),
        padding: EdgeInsets.only(left: 14),
        child: TextFormField(
          enabled: enable,
          style: TextStyle(fontSize: 18),
          controller: nameController,
          keyboardType: keyBoard,
          cursorColor: Colors.black45,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: " ",
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
    ],
  );
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
const _chars3 = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
const _chars1 = '1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getRandomStringOnly(int length) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars3.codeUnitAt(_rnd.nextInt(_chars3.length))));

String getRandomInt(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars1.codeUnitAt(_rnd.nextInt(_chars1.length))));

double getRandomInInt(int length) {
  return double.parse(getRandomInt(length));
}

Future<bool> checkInternet() async {
  try {
    return await InternetAddress.lookup('www.google.com').then((result) {
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        customPrint('connected');
        return true;
      }
      return false;
    });
  } on SocketException catch (_) {
    customPrint('not connected');
    return false;
  }
}

Future<void> copyToClipboard(context, copyText) async {
  await Clipboard.setData(ClipboardData(text: copyText));
  showSnackbar(context, '$copyText Copied to clipboard', Colors.green);
}

int getJsonLength(jsonData) {
  int len = 0;
  try {
    while (jsonData[len] != null) {
      len++;
    }
    // customPrint("Len :: $len");
  } catch (e) {
    // customPrint("Len Catch :: $len");
    return len;
  }
  return 0;
}

String stringToJson(String key, String value) {
  String dff = ("\"" + key + "\"\r" + ": \"" + value + "\"\r").toString();
  String jsonText = '"$key": "$value"';
  customPrint("Dff :: $jsonText");
  return jsonText;
}

bool debugMode = false;

checkDebugMode() {
  assert(() {
    debugMode = true;
    return true;
  }());
}

void customPrint(text) {
  if (debugMode) {
    rahul.log(text);
  }
}

void customLog(text) {
  if (debugMode) {
    rahul.log(text);
  }
}

String getStringCont(String cont) {
  return cont.replaceAll("+91", "").toString().trim();
}

String getStringInt(String text) {
  try {
    String data = "";
    data = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.parse(data).toString();
  } catch (e) {
    return "3";
  }
}

List<String> stringToList(String str, [String delim = ","]) {
  String removedBrackets = str.replaceAll("[", "");
  removedBrackets = removedBrackets.replaceAll("]", "");
  List<String> parts = removedBrackets.split(delim);
  parts.remove("");
  // customPrint("parts :: $parts");
  return parts;
}

String listToString(List list) {
  String data = "";
  for (int i = 0; i < list.length; i++) {
    data = "$data${list[i]},";
  }

  customPrint("listToString :: $data");

  return data;
}

bool kIsValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String rupees = "Rs.";

class SplitArray {
  static List list1 = [];
  static List list2 = [];
  static List mergeList = [];

  static void split(List array, [String delim = "{}"]) {
    list1.clear();
    list2.clear();
    for (int i = 0; i < array.length; i++) {
      list1.add(array[i].toString().split(delim)[0]);
      list2.add(array[i].toString().split(delim)[1]);
    }
    customPrint("List 1 :: $list1");
    customPrint("List 2 :: $list2");
  }

  static void add(List array1, List array2, [String delim = "{}"]) {
    mergeList.clear();
    for (int i = 0; i < array1.length; i++) {
      mergeList.add(array1[i] + delim + array2[i]);
    }
  }
}

// void logoutUser(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Logout"),
//         content: const Text("Do you really want to Logout?"),
//         actions: [
//           TextButton(
//             child: const Text(
//               "Yes",
//               style: TextStyle(color: colorDark),
//             ),
//             onPressed: () async {
//               Navigator.pop(context);
//               await FirebaseAuth.instance.signOut();
//               // GoogleLoginApi.signOut();
//               // EmailPasswordAuth.signOut();
//               await prefs.setBool("login", false);
//               nextPage(context, const WelcomePage());
//             },
//           ),
//           TextButton(
//             child: const Text(
//               "No",
//               style: TextStyle(color: colorDark),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )
//         ],
//       );
//     },
//   );
// }

void AppExitPopup(BuildContext context,
    [String title = "Exit", String subTitle = "Do you really want to exit ?"]) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => exit(0),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

showSuccessDialog(BuildContext context,
    [String text = "Process done successfully"]) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12, top: 12),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}

showWarningDialog(BuildContext context, [String text = "You have warning !"]) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12, top: 12),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.redAccent),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}

Future<void> delay(int time) async {
  await Future.delayed(Duration(milliseconds: time));
}

showConfirmDialog(BuildContext context, String messageKey, Function onYes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(messageKey),
        content: Text("Do you really want to ${messageKey.toLowerCase()}?"),
        actions: [
          TextButton(
            child: const Text(
              "Yes",
              style: TextStyle(color: colorDark),
            ),
            onPressed: () async {
              Navigator.pop(context);
              onYes();
            },
          ),
          TextButton(
            child: const Text(
              "No",
              style: TextStyle(color: colorDark),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

bool validateMyFields(BuildContext context,
    List<TextEditingController> controllerList, List<String> fieldsName) {
  for (int i = 0; i < controllerList.length; i++) {
    if (controllerList[i].text.trim().isEmpty) {
      showSnackbar(context, "${fieldsName[i]} Can't be empty", colorError);
      i = controllerList.length + 1;
      return false;
    }
  }
  return true;
}

String addZero(int sec) {
  if (sec < 10) {
    return "0$sec";
  }
  return "$sec";
}

String flutterMapValue(outputStart, outputEnd, inputStart, inputEnd, input) {
  String output = (outputStart +
          ((outputEnd - outputStart) / (inputEnd - inputStart)) *
              (input - inputStart))
      .toString();
  // customPrint("Loading Return :: $output");
  return output;
}

String checkNull(String? text, [String res = "NA"]) {
  if (text == null ||
      text.toString().trim() == "" ||
      text.toString().trim().isEmpty) {
    return res;
  }

  return text;
}
