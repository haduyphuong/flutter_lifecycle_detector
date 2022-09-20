import Flutter
import UIKit
import UserNotifications

public class SwiftFlutterLifecycleDetectorPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    private var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftFlutterLifecycleDetectorPlugin()
        let lifeCycleName = "flutter_lifecycle_detector"
        let channel = FlutterEventChannel(name: lifeCycleName, binaryMessenger: registrar.messenger())
        
        channel.setStreamHandler(instance as FlutterStreamHandler & NSObjectProtocol)
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(instance, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        notificationCenter.addObserver(instance, selector: #selector(willEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    public func onListen(withArguments arguments: Any?,
                         eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    @objc func didEnterBackground() {
        self.eventSink?("background")
    }
    
    @objc func willEnterForeground() {
        self.eventSink?("foreground")
    }
    
}