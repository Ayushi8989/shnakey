import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:neon/widgets/bottomnavigation.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
