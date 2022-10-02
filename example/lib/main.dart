import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_detector/flutter_lifecycle_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterLifecycleDetector().onBackgroundChange.listen((isBackground) {
      /// `isBackground` is true => background
      /// `isBackground` is false => foreground
      log('Status background $isBackground');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('flutter_lifecycle_detector'),
        ),
      ),
    );
  }
}
