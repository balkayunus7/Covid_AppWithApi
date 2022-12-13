// ignore_for_file: file_names

import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/WorldStates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WorldStatesScreen(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _Utilities utilities = _Utilities();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedBox(context),
            SizedBox(
              height: utilities.contDimension,
              width: utilities.contDimension,
              child: Center(
                child: Lottie.asset(utilities.lottieUrl),
              ),
            ),
            sizedBox(context),
            Align(
              alignment: Alignment.center,
              child: Text(
                utilities.titleText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox sizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .08,
    );
  }
}

class _Utilities {
  final String titleText = "Covid-19\nTracker App";
  final String lottieUrl = "images/26140-covid19.json";
  final double contDimension = 300;
}
