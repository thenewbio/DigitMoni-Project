import 'dart:async';
import '/helper_class.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;
  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: animation.value * 400,
                    child: Image.asset("assets/welcome_screen.png")),
                // Text("communityapp",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold, fontSize: 50),)
              ]),
        ],
      ),
    );
  }
}
