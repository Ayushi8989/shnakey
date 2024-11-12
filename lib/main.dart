import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:neon/Notification/notification.dart';
import 'package:neon/Snakey/pregame.dart';
import 'package:neon/slidenseek/home_screen.dart';
import 'Ad/google_ad.dart';
import 'Database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// final GlobalKey<SnakeGameState> snakeGameKey = GlobalKey<SnakeGameState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final adController = Get.put(AdBannerController());
  final rewardedAdController = Get.put(RewardedAdController());
  final pointController = Get.put(FirebaseController());
  final interController = Get.put(InterstitialAdController());
  // final notificationController = Get.put(LocalNotificationController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            // if (snapshot.hasData) {
            //   return Home();
            // } else {
            //   return LoginPage();
            // }
            return HomeScreen();
          })),
    );
  }
}
