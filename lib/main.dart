import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splash_screen_with_timer/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(229, 208, 30, 1),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 208, 30, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
          ),
          child: Center(
            child: Container(
              child: Image.asset(
                "assets/24701-nature-natural-beauty.jpg",
                width: 200,
                height: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
