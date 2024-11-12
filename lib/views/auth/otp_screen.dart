import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neon/authentication/auth_services.dart';
import 'package:neon/authentication/phone_auth.dart';
import 'package:neon/views/auth/account.dart';
// import 'package:neon/views/home.dart';
import 'package:neon/views/auth/login_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/widgets.dart';
import '../HomeSection/home.dart';

class OtpScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? name;
  final String? fromPage;
  const OtpScreen(
      {super.key,
      this.phoneNumber,
      this.email,
      this.password,
      this.name,
      this.fromPage});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;
  String? _verificationId;
  bool otpEntered = false;
  String otp = "";
  String sentOtp = "";
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  bool resend = false;
  Duration _duration = Duration(seconds: 60);
  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);

          // Check if remaining duration is less than or equal to 2 minutes
          if (_duration.inSeconds == 0) {
            setState(() {
              resend = true;
            });
          } else {
            setState(() {
              resend = false;
            });
          }
        } else {
          _stopTimer();
        }
        print(_duration.inSeconds);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PhoneAuth.verifyWithPhoneNumber(context, widget.phoneNumber as String);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');
    print(sentOtp);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
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
                      onTap: () => Navigator.pop(context),
                      child: CustomBackButton()),
                  SizedBox(
                    height: height / 10,
                  ),
                  BigText(
                    text: "Enter verification code",
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text(
                      "Enter 6-digit code the we just send to your phone number: ${widget.phoneNumber}",
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
                  Form(
                    key: _formKey,
                    child: PinCodeTextField(
                      appContext: context,
                      controller: _otpController,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      length: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter OTP";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          otp = value;
                        });
                      },
                      onCompleted: (value) {
                        setState(() {
                          isLoading = false;

                          otpEntered = true;
                        });
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        selectedColor: Colors.black,
                        inactiveColor: Colors.purple,
                        disabledColor: AppColor.darkPurple,
                        activeFillColor: Colors.transparent,
                        activeColor: AppColor.lightPurple,
                        inactiveFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.darkPurple,
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          "0:$seconds",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PhoneAuth.verifyWithPhoneNumber(
                                context, widget.phoneNumber.toString());

                            setState(() {
                              _duration = Duration(seconds: 60);
                              otpEntered = false;
                            });
                            _startTimer();
                          },
                          child: Text(
                            "Resend otp",
                            style: TextStyle(
                                color: resend
                                    ? AppColor.lightPurple
                                    : Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Align(
                    child: otpEntered
                        ? GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                // await PhoneAuth.signWithPhoneNumber(
                                //     context, otp);
                                await AuthServices.signUpUser(
                                  widget.email as String,
                                  widget.password as String,
                                  widget.name as String,
                                  widget.phoneNumber as String,
                                  context,
                                ).whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                });
                                // await AuthServices.signInWithOtp(
                                //   _verificationId as String,
                                //   otp,
                                //   context,
                                //   widget.email as String,
                                //   widget.name as String,
                                // );

                                setState(() {
                                  isLoading = false;
                                });
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
                                  "Verify!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
