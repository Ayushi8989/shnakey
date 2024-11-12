import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// import 'package:neon/views/home.dart';
import 'package:neon/views/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Auth()));
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user == null) {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => LoginPage()));
      //     print('User is currently signed out!');
      //   } else {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => Home()));
      //     print('User is signed in!');
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splashScreen.jpeg"),
                    fit: BoxFit.cover))));
  }
}
