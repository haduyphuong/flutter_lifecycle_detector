import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_detector/flutter_lifecycle_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterLifecycleDetector().onBackgroundChange.listen((event) {

      // $event is true => background
      // $event is true => foreground
      log('Status background $event');
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
