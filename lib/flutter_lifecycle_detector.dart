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
    // Get data stream from native with event channel.
    _eventChannel.receiveBroadcastStream().listen((isBackground) {
      /// `isBackground` is true => background
      /// `isBackground` is false => foreground
      // Push data to stream
      _streamController.sink.add(isBackground == 'background');
    });
  }

  Stream<bool> get onBackgroundChange => _streamController.stream;

  void cancel() {
    // Close stream
    _streamController.close();
  }
}
