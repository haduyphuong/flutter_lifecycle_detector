# flutter_lifecycle_detector

A plugin flutter detect app entering background or foreground mode.
Plugin only support Android, iOS.

Add package to project:

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```flutter_lifecycle_detector: ^0.0.5```

## Detect background mode

```
FlutterLifecycleDetector().onBackgroundChange.listen((event) {

  /// `isBackground` is true => background
  /// `isBackground` is false => foreground
  log('Status background $event');
});
```

## Full example:
```import 'dart:developer';

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
    // Detect mode background
    FlutterLifecycleDetector().onBackgroundChange.listen((event) {

      /// `isBackground` is true => background
      /// `isBackground` is false => foreground
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
```