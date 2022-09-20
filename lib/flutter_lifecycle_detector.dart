import 'dart:async';

import 'package:flutter/services.dart';

class FlutterLifecycleDetector {
  static final _singleton = FlutterLifecycleDetector._();
  FlutterLifecycleDetector._();
  factory FlutterLifecycleDetector() {
    _lifeCycleListener(); 
    return _singleton;
  }
  static final _streamController = StreamController<bool>.broadcast();

  static const _eventChannel = EventChannel('flutter_lifecycle_detector');

  static void _lifeCycleListener() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      // $event is true => background
      // $event is true => foreground
      _streamController.sink.add(event == 'background');
    });
  }

  Stream<bool> get onBackgroundChange => _streamController.stream;

  void cancel() {
    _streamController.close();
  }
}
