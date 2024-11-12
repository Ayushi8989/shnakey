import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neon/authentication/auth_services.dart';
import 'package:neon/authentication/phone_auth.dart';
import 'package:neon/views/auth/account.dart';
// import 'package:neon/views/home.dart';
import 'package:neon/views/auth/login_page.dart';
import 'package:neon/views/auth/verify_account.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/widgets.dart';
import 'otp_screen.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool visible = true;
  String _errorMessage = '';
  String? _verificationId;
  bool isLoading = false;
  bool isChecked = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  String _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xff1d011c),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 19.5, vertical: height / 14.06),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CustomBackButton()),
                  ],
                ),
                SizedBox(
                  height: height / 10,
                ),
                BigText(
                  text: "Sign Up",
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Create an account to continue",
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
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            contentPadding: EdgeInsets.all(24),
                            hintText: "Full Name",
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text("Full Name")],
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
                        Column(children: [
                          IntlPhoneField(
                            flagsButtonPadding: EdgeInsets.only(left: 10),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.purple,
                            ),
                            cursorColor: AppColor.darkPurple,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: GradientOutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    AppColor.lightPurple,
                                    AppColor.darkPurple
                                  ]),
                                  width: 2),
                            ),
                            initialCountryCode: 'IN',
                            pickerDialogStyle: PickerDialogStyle(
                                searchFieldInputDecoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: GradientOutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        AppColor.lightPurple,
                                        AppColor.darkPurple
                                      ]),
                                      width: 2),
                                ),
                                searchFieldCursorColor: AppColor.lightPurple,
                                countryCodeStyle:
                                    TextStyle(color: Colors.white),
                                countryNameStyle: TextStyle(color: Colors.pink),
                                backgroundColor: AppColor.backgroundColor),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (phone) {
                              setState(() {
                                _phoneNumber = phone.completeNumber;
                              });
                            },
                          ),
                        ]),
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
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
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
                Row(
                  children: [
                    Checkbox(
                        activeColor: AppColor.darkPurple,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    Text(
                      "I agree to the Terms of Service ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "SpaceGrotesk"),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 40,
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
                            _formKey.currentState!.save();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    name: _nameController.text,
                                    phoneNumber: _phoneNumber,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                ));
                          }
                        },
                        child: Center(
                          child: Text(
                            "Sign Up",
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
                      "Already have an account ? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "SpaceGrotesk"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: AppColor.lightPurple,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SpaceGrotesk"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
