import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neon/authentication/auth_services.dart';

import '../../widgets/big_text.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/widgets.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _nameController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Color(0xff1d011c),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 19.5, vertical: height / 14.06),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomBackButton()),
                SizedBox(
                  height: height / 10,
                ),
                BigText(
                  text: "Forgot Password",
                ),
                SizedBox(
                  height: height / 20,
                ),
                Text(
                    "Enter your email address so we can send you the reset link",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: height / 20,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextFeild(
                  Controller: _nameController,
                  hintText: "Email",
                ),
                SizedBox(
                  height: height / 20,
                ),
                Align(
                  child: GestureDetector(
                    onTap: () async {
                      isloading = true;
                      if (_nameController.text.isNotEmpty) {
                        await AuthServices.resetPassword(
                            _nameController.text.trim(), context);
                        isloading = false;
                      }
                    },
                    child: Container(
                      height: height / 14.06,
                      width: width / 1.56,
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
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
