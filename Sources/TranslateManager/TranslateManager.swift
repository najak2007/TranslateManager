// The Swift Programming Language
// https://docs.swift.org/swift-book

import Translation

@available(iOS 18.0, *)
@objc(TranslateManager)
open class TranslateManager: NSObject {
    static let viewModel = ViewModel()

    @objc public static func preferences(langPacks: Array<String> = ["en"], completion: @escaping (String) -> Void) {      // Callback String - Error code
        
    }
    
    @objc public static func getAvailableLangModels() async -> Array<String> {
        var availableLanguages : Array<String> = []
        let supportedLanguages = await TranslateManager.viewModel.prepareSupportedLanguages()
        
        supportedLanguages.forEach { language in
            availableLanguages.append(language.localizedName())
        }
        return availableLanguages
    }
}
