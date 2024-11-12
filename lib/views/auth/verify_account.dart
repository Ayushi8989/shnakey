import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/widgets.dart';
import 'account.dart';

class VerifyAccount extends StatelessWidget {
  VerifyAccount({super.key});
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                    Navigator.pop(context);
                  },
                  child: CustomBackButton()),
              SizedBox(
                height: height / 10,
              ),
              BigText(
                text: "Verify Account",
              ),
              SizedBox(
                height: height / 20,
              ),
              Text(
                  "Enter your phone number so we can send you the verification code",
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
                  child: Column(
                    children: [
                      IntlPhoneField(
                        controller: _numberController,
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
              SizedBox(
                height: height / 20,
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Account()));
                        }
                      },
                      child: Center(
                        child: Text(
                          "Verify Account",
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
            ],
          ),
        ),
      ),
    );
  }
}
