// The Swift Programming Language
// https://docs.swift.org/swift-book

import Translation

@available(iOS 18.0, *)
@objc(TranslateManager)
open class TranslateManager: NSObject {
    
    @objc public let shared = TranslateManager()
    @MainActor private var viewModel = ViewModel()
    
    
    @objc public static func preferences(langPacks: Array<String> = ["en"], completion: @escaping (String) -> Void) {      // Callback String - Error code
        
    }
    
    @MainActor @objc public func getAvailableLangModels(completion: @escaping ([String]) -> Void) {
        var availableLanguages : Array<String> = []
        viewModel.availableLanguages.forEach { language in
            availableLanguages.append(language.localizedName())
        }
        completion(availableLanguages)
    }
}
