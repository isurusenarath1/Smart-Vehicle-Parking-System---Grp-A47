import 'dart:async';

import 'package:parkingexpress/Views/Auth/login.dart';
import 'package:parkingexpress/Views/Contents/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Controllers/AuthController.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Images.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: displaySize.width * 0.5,
                child: Image.asset(logo),
              )),
        ],
      )),
    );
  }

  Future<void> startApp() async {
    if (await CustomUtils.getAuth() != null &&
        await _authController.doLoginCheck()) {
      Routes(context: context).navigateReplace(const Home());
    } else {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        _timer!.cancel();
        Routes(context: context).navigateReplace(const Login());
      });
    }
  }
}
