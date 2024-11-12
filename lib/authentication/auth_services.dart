import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neon/utils/colors.dart';
import 'package:neon/utils/global_variable.dart';

import '../Database/database.dart';

class AuthServices {
  static signUpUser(String email, String password, String name,
      String phoneNumber, BuildContext context) async {
    try {
      // Create a user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Verify the entered OTP
      // PhoneAuthCredential phoneCredential =
      //     PhoneAuthProvider.credential(verificationId: vid, smsCode: code);
      // await FirebaseAuth.instance.currentUser!
      //     .updatePhoneNumber(phoneCredential);

      // Update user's display name and email
      User? currentUser = FirebaseAuth.instance.currentUser;
      await currentUser!.updateDisplayName(name);
      await currentUser.updateEmail(email);
      await currentUser.updatePhotoURL(
          "https://firebasestorage.googleapis.com/v0/b/neon-661d5.appspot.com/o/avatars%2FAVATAR.png?alt=media&token=26dab19c-bd27-4818-b58b-5d90bedc4d48");

      // Save user to Firestore
      await FireStoreServices.saveUser(name, email, userCredential.user!.uid);

      // Show success snackbar
      Get.snackbar(
          "Registration Successful", "Welcome ${userCredential.user!.email}",
          backgroundColor: AppColor.greenColor, colorText: Colors.white);
      points.value = 0;
      lives.value = 3;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Please provide a password of length more than 6."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("The account already exists for that email."),
          ),
        );
      } else if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Invalid OTP. Please enter a correct OTP."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.redColor,
          content: Text("Something went wrong."),
        ),
      );
    }
  }

  static signInUser(String email, String password, BuildContext context) async {
    final FirebaseController _controller = Get.find<FirebaseController>();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Login Successful", "Welcome ${userCredential.user!.email}",
          backgroundColor: AppColor.greenColor, colorText: Colors.white);
      _controller.getLives();
      _controller.getAdminOption();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("No user found for that email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Password Incorrect."),
          ),
        );
      }
    }
  }

  static signInWithGoogle(BuildContext context) async {
    final FirebaseController _controller = Get.find<FirebaseController>();
    try {
      final provider = GoogleAuthProvider();
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await FireStoreServices.saveUser(googleUser.displayName!,
          googleUser.email!, FirebaseAuth.instance.currentUser!.uid);
      _controller.getLives();
      _controller.getAdminOption();

      print(userCredential.user!.displayName);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static signInWithOtp(
    String verificationId,
    String otp,
    BuildContext context,
  ) async {
    try {
      // Create a PhoneAuthCredential with the verification ID and OTP
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Update the user's email and password

      // await FirebaseAuth.instance.currentUser!.updatePassword(password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.greenColor,
          content: Text("Sign in successful"),
        ),
      );

      // You can now proceed with the desired navigation or actions after successful sign-in
      // ...
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Invalid verification code. Please try again."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Sign in failed. Please try again."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.redColor,
          content: Text("Something went wrong"),
        ),
      );
    }
  }

  static resetPassword(String email, BuildContext context) async {
    try {
      // Step 1: Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Step 2: Show password reset instructions message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.greenColor,
          content: Text("Password reset instructions sent to your email"),
        ),
      );

      // Step 3: Proceed with further actions after sending reset email
      // For example, navigate to the login screen or perform additional tasks
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("No user found with this email"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("Password reset failed. Please try again."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.redColor,
          content: Text("Something went wrong"),
        ),
      );
    }
  }
}
