import Foundation

class FileHandler {
    static let shared = FileHandler()
    
    func fetchSharedFilePath() -> URL? {
        if let savedPath = UserDefaults.standard.string(forKey: "sharedFilePath") {
            return URL(fileURLWithPath: savedPath)
        }
        return nil
    }
    
    func saveSharedFilePath(_ url: URL) {
        UserDefaults.standard.setValue(url.path, forKey: "sharedFilePath")
        UserDefaults.standard.synchronize()
    }
}
