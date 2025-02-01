import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Проверяем, был ли передан файл через Share Extension
        if let sharedFileURL = FileHandler.shared.fetchSharedFilePath() {
            sendFilePathToFlutter(sharedFileURL.path)
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Обработка открытия файлов извне
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        sendFilePathToFlutter(url.path)
        return true
    }
    
    // Передача пути файла в Flutter через MethodChannel
    private func sendFilePathToFlutter(_ filePath: String) {
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "file_open_channel", binaryMessenger: controller.binaryMessenger)
            channel.invokeMethod("onFileOpen", arguments: filePath)
        }
    }
}
