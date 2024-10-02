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
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! B O D Y
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(4, -0.4),
            child: Container(
              height: 300,
              width: 400,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-4, 0.9),
            child: Container(
              height: 300,
              width: 400,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.4),
            child: Container(
              height: 300,
              width: 600,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 47, 6, 141)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          //! S P L A S H - I M A G E
          Center(
            child: Image.asset('assets/todo.png'),
          )
        ],
      ),
    );
  }
}
