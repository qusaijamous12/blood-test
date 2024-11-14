import 'dart:async';

import 'package:blood_test/presentaion_layer/resources/color_%20manger/color_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer ?_time;

  _onFinish(){
    Get.offAll(()=>const LoginScreen());
  }

  @override
  void initState() {

    _time=Timer(const Duration(seconds: 2), _onFinish);
    super.initState();
  }
  @override
  void dispose() {
    _time?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.kPrimary,
      body:Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
