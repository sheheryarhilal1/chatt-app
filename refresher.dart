import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_chat_app/Next_screen.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/image/logo.png',
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Image.asset(
              'assets/image/refresher.png',
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
