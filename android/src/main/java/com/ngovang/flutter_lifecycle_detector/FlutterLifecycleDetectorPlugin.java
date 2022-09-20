package com.ngovang.flutter_lifecycle_detector;


import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;
import androidx.lifecycle.ProcessLifecycleOwner;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;

/**
 * FlutterLifecycleDetectorPlugin
 */
public class FlutterLifecycleDetectorPlugin implements FlutterPlugin, EventChannel.StreamHandler, LifecycleObserver, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;


    // Application level lifecycle events
    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    public void onEnteredForeground() {
        sendEvent("foreground");
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    public void onEnteredBackground() {
        sendEvent("background");
    }

    private void sendEvent(String event) {
        if (eventSink == null) return;
        eventSink.success(event);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_lifecycle_detector");
        eventChannel.setStreamHandler(this);
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        eventChannel.setStreamHandler(null);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        ProcessLifecycleOwner.get().getLifecycle().addObserver(this);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {
        ProcessLifecycleOwner.get().getLifecycle().removeObserver(this);
    }
}
