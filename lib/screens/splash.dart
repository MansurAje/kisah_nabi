import 'dart:async';

import 'package:kisah_nabi/screens/home.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:easy_splash_screen/easy_splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool position = false;
  var opacity = 0.0;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() async {
    if (opacity == 0) {
      opacity = 1;
      position = true;
    } else {
      opacity = 0;
      position = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(image: AssetImage('assets/images/kisah.png')),
      logoWidth: 150,
      backgroundColor: Colors.white,
      showLoader: true,
      //loadingText: Text("kisah_nabi"),
      navigator: const Home(),

      // mansur 20221028 : durationInSecond diset minimal 15, karena butuh waktu untuk check blockedAPP, jika kurang waktunya. maka akan failed untuk check Blocked App
      durationInSeconds: 3,
    );
  }
}
