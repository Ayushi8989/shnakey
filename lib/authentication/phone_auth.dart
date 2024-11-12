import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

String _verificationId = "";
final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneAuth {
  // static Future<void> verifyPhoneNumber(
  //   String phoneNumber,
  //   Function(String verificationId, String? sentOTP) onSuccess,
  //   Function(String errorMessage) onError,
  // ) async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         onError(e.message as String);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         // Retrieve the sent OTP here
  //         String? sentOTP;
  //         // Manually extract the OTP from the verification message or any other source
  //         // and assign it to the 'sentOTP' variable.
  //         // Example: sentOTP = extractOTPFromMessage();

  //         onSuccess(verificationId, sentOTP);
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  static Future<void> verifyWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential).then((user) async {
        print("phoneAuthCredential :: $phoneAuthCredential");
        final User? user = auth.currentUser;
        if (user != null) {
          print("User ::" + user.toString());
          final uid = user.uid;
          print("uid :: $uid");
          // nextPage(context, const ProfilePage());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.redColor,
              content: Text("otp not correct"),
            ),
          );
          print("OTP Error");
        }
      }).catchError((error) {
        print(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text("otp not correct"),
          ),
        );
      });
    };

    ///Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.redColor,
          content: Text(
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}'),
        ),
      );
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
      print("_verificationId1 :: $_verificationId");
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      print("_verificationId2 :: $_verificationId");
    };

    try {
      await _auth
          .verifyPhoneNumber(
              phoneNumber: phoneNumber,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        print("Code :: $codeSent");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> signWithPhoneNumber(
      BuildContext context, String otp) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential).then((user) async {
        print("credential New  :: $credential");
        final User? user = auth.currentUser;
        print("User ::" + user.toString());
        final uid = user?.uid;
        print(uid);

        return true;
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.redColor,
            content: Text(error.toString()),
          ),
        );

        return false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.redColor,
          content: Text('invalid otp'),
        ),
      );
    }
    return false;
  }
}
