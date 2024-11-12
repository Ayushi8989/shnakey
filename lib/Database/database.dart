import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/global_variable.dart';

class FireStoreServices {
  static saveUser(String name, String email, String uid) async {
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!snapshot.exists) {
      await FirebaseFirestore.instance.collection("users").doc(uid).set(
        {
          "name": name,
          "email": email,
          "uid": uid,
          'lives': 3,
          'lastUpdated': DateTime.now(),
          'adShowCount': 0,
          'points': 0,
        },
      );
    } else {
      print("uid already exists");
    }
  }
}

RxInt points = 0.obs;
RxInt pointToMoney = 0.obs;
RxInt timer = 0.obs;

class FirebaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getLives();
    getAdminOption();

    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void getLives() async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        final data = snapshot.data();
        if (data != null) {
          print(data);
          lives.value = data['lives'] ?? 0;
          adShowCount.value = data['adShowCount'] ?? 0;
          points.value = data['points'] ?? 0;
        }
      });
    }
  }

  void getAdminOption() async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('AdminOptions')
          .doc("AdminOptions")
          .snapshots()
          .listen((snapshot) {
        final data = snapshot.data();
        if (data != null) {
          print(data);

          pointToMoney.value = data['pointToMoney'] ?? 0;
          timer.value = data['timer'] ?? 0;
        }
      });
    }
  }

  void increaseLives() {
    if (lives.value < 3) {
      lives.value++;
      updateLivesInFirestore();
    } else {
      Get.snackbar('Please wait', 'Cannot Increase Lives ',
          duration: Duration(seconds: 5), colorText: Colors.white);
      print("connot increase");
    }
  }

  void decreaseLives() {
    if (lives.value > 0) {
      lives.value--;
      updateLivesInFirestore();
    } else {
      // showNotification('Cannot decrease lives below 0');
    }
  }

  void updateLivesInFirestore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        'lives': lives.value,
        'lastUpdated': DateTime.now(),
        'adShowCount': adShowCount.value
      });
    }
  }

  void updatePointsInFireStore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        'points': points.value + 100,
      });
    }
  }

  checkResetLives() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        final data = snapshot.data();
        if (data != null) {
          print(data);
          DateTime lastUpdated = data['lastUpdated'].toDate();
          DateTime now = DateTime.now();
          int difference = now.difference(lastUpdated).inMinutes;
          print("the time difference is :: $difference");

          if (difference >= 2) {
            resetLivesTo3();
          }
        }
      });
    }
  }

  resetLivesTo3() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(
              {'lives': 3, 'lastUpdated': DateTime.now(), 'adShowCount': 0});
    }
  }

  // void showNotification(String message) {
  //   final snackBar = SnackBar(
  //     content: Text(message),
  //     duration: const Duration(seconds: 2),
  //   );
  //   scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  // }
  Timer? _timer;
  int _counter = 0;
  void startTimer() {
    // final notiController = Get.put(LocalNotificationController());
    print("Timer is running");
    const duration = Duration(minutes: 3);
    _timer = Timer.periodic(duration, (timer) {
      _counter++;
      if (_counter >= 3) {
        resetLivesTo3();
        // notiController.showNotification();

        _counter = 0;
      }
    });
  }
}
