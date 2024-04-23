import 'dart:async';

import 'package:covid_tracker/view/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldState()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black45.withOpacity(0.2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              child: Container(
                child: Image.asset("assets/images/virus_trans_bg.png"),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Covid_19\nTrackerApp",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
