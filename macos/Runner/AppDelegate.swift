import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  // Обработка открытия файлов
  override func application(_ application: NSApplication, open urls: [URL]) {
    let filePaths = urls.map { $0.path } // Извлекаем пути к файлам
    let controller = self.mainFlutterWindow?.contentViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "file_open_channel", binaryMessenger: controller.engine.binaryMessenger)
    
    // Передаем пути файлов в Flutter
    channel.invokeMethod("onFileOpen", arguments: filePaths)
  }
}
