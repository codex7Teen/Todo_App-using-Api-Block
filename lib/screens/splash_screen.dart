import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app_api_block/screens/home_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  // Navigate to Homescreen after 3 seconds
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(4, -0.4),
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-4, 0.9),
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -1.4),
            child: Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(color: Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
          Center(
            child: Image.asset('assets/todo.png'),
          )
        ],
      ),
    );
  }
}
