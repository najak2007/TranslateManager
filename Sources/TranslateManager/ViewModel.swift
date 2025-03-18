//
//  ViewModel.swift
//  TranslateManager
//
//  Created by najak on 3/17/25.
//

import Foundation
@preconcurrency import Translation

@MainActor
class ViewModel {
    var translatedText = ""
    var isTranslationSupported: Bool?
    var selectedFrom: Locale.Language?
    var selectedTo: Locale.Language?
    
    var availableLanguages: [AvailableLanguage] = []

    var selectedLanguagePair: LanguagePair {
        LanguagePair(selectedFrom: selectedFrom, selectedTo: selectedTo)
    }
    
    init() {
        prepareSupportedLanguages()
    }

    func prepareSupportedLanguages() {
        Task { @MainActor in
            let supportedLanguages = await LanguageAvailability().supportedLanguages
            availableLanguages = supportedLanguages.map {
                AvailableLanguage(locale: $0)
            }.sorted()
        }
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

struct LanguagePair: Equatable {
    var selectedFrom: Locale.Language?
    var selectedTo: Locale.Language?
    
    static func == (lhs: LanguagePair, rhs: LanguagePair) -> Bool {
        return lhs.selectedFrom == rhs.selectedFrom && lhs.selectedTo == rhs.selectedTo
    }
}
