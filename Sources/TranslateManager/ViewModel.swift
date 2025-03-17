//
//  ViewModel.swift
//  TranslateManager
//
//  Created by najak on 3/17/25.
//

import Foundation
import Translation

@Observable
class ViewModel {
    var translatedText = ""
    var isTranslationSupported: Bool?
    
    var availableLanguages: [AvailableLanguage] = []

    init() async {
        await prepareSupportedLanguages()
    }

    func prepareSupportedLanguages() async {
        let supportedLanguages = await LanguageAvailability().supportedLanguages
        availableLanguages = supportedLanguages.map {
            AvailableLanguage(locale: $0)
        }.sorted()
    }
}

extension ViewModel {
    func checkLanguageSupport(from source: Locale.Language, to target: Locale.Language) async {
        let availability = LanguageAvailability()
        let status = await availability.status(from: source, to: target)
        
        switch status {
        case .installed, .supported:
            isTranslationSupported = true
        case .unsupported:
            isTranslationSupported = false
        @unknown default:
            print("Not supported")
        }
    }
}
