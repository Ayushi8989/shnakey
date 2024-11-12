import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neon/authentication/auth_services.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/views/auth/account.dart';
import 'package:neon/views/auth/registration_page.dart';

import 'package:neon/widgets/my_text_feild.dart';

import '../../widgets/big_text.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/widgets.dart';
import 'forgot_password.dart';
// import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          backgroundColor: Color(0xff1d011c),
          body: Padding(
            padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Image.asset(
                      "assets/neonlogo.png",
                      height: 40,
                    ),
                  ),
                  SizedBox(
                    height: height / 10.3,
                  ),
                  BigText(
                    text: "Let's Sign In",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Welcome Back!",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: height / 20,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: false,
                            style: TextStyle(color: Colors.white),
                            cursorColor: AppColor.darkPurple,
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Email';
                              } else if (!EmailValidator.validate(
                                  value as String)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: EdgeInsets.all(24),
                              hintText: "Email",
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("Email")],
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: GradientOutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    AppColor.lightPurple,
                                    AppColor.darkPurple
                                  ]),
                                  width: 2),
                            ),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          TextFormField(
                            autofocus: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            obscureText: visible ? true : false,
                            style: TextStyle(color: Colors.white),
                            cursorColor: AppColor.darkPurple,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                child: visible
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )
                                    : Icon(Icons.visibility_off,
                                        color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: EdgeInsets.all(24),
                              hintText: "Password",
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text('Password')],
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: GradientOutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    AppColor.lightPurple,
                                    AppColor.darkPurple
                                  ]),
                                  width: 2),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: height / 80,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                      },
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    height: height / 14.06,
                  ),
                  Align(
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Colors.white.withOpacity(0.5),
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              _formKey.currentState!.save();
                              await AuthServices.signInUser(
                                  _emailController.text,
                                  _passwordController.text,
                                  context);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "SpaceGrotesk"),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppColor.lightPurple,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SpaceGrotesk"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //Google Sign In
                  Align(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthServices.signInWithGoogle(context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                          height: height / 14.5,
                          width: width / 1.56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                Color(0xffE93DE5),
                                Color(0xff922DC1),
                              ]),
                            ),
                          ),
                          child: Image.asset("assets/logo.png")),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
