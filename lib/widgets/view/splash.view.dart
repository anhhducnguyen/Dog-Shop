import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor : Color(0xFF1E319D),
      body: Center(
        child: Text(
          'Dog Wiki',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
