// The Swift Programming Language
// https://docs.swift.org/swift-book

import Translation

@available(iOS 18.0, *)
@objc(TranslateManager)
class TranslateManager: NSObject {

    
    
    @objc static func preferences(langPacks: Array<String> = ["en"], completion: @escaping (String) -> Void) {      // Callback String - Error code
        
    }
    
    @objc static func getAvailableLangModels(completion: @escaping ([String]) -> Void) {
        
    }
}
