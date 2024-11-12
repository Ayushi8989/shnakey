import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/HomeSection/home.dart';

class AlertExit extends StatelessWidget {
  const AlertExit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColor.backgroundColor,
      title: Text(
        'Exit Game',
        style: TextStyle(color: AppColor.textColorGrey),
      ),
      content: Text(
        'Are you sure you want to exit the game ?',
        style: TextStyle(color: AppColor.textColorGrey),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColor.textColorGrey)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: const Text('Yes'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColor.textColorGrey)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
