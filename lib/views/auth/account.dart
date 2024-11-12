import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:neon/views/home_page.dart';
// import 'package:neon/views/setting.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/widgets.dart';
import '../HomeSection/home.dart';
import '../HomeSection/setting.dart';
// import 'home.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool visible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  child: CustomBackButton()),
              Align(
                child: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    child: Image.asset("assets/AVATAR.png"),
                  ),
                ),
              ),
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        style: TextStyle(color: Colors.white),
                        cursorColor: AppColor.darkPurple,
                        controller: _firstnameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.all(24),
                          hintText: "Last Name",
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text("Last Name")],
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            countryCodeStyle: TextStyle(color: Colors.white),
                            countryNameStyle: TextStyle(color: Colors.pink),
                            backgroundColor: AppColor.backgroundColor),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ],
                  )),
              Align(
                child: Container(
                  height: height / 14.06,
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      splashColor: AppColor.lightPurple.withOpacity(0.5),
                      highlightColor: Colors.transparent,
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
