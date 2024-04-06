//
//  ThemeManager.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 4.04.2024.
//

import Foundation
import UIKit

enum ThemeMode {
    case light, dark
}

class ThemeManager {
    static func toggleTheme() {
        // Mevcut tema modunu kontrol et
        let currentMode = UIApplication.shared.windows.first?.traitCollection.userInterfaceStyle ?? .unspecified
        let newMode: ThemeMode = (currentMode == .dark) ? .light : .dark

        // Tema değişikliklerini uygula
        applyTheme(mode: newMode)
    }

    static func applyTheme(mode: ThemeMode) {
        switch mode {
        case .light:
            // Aydınlık tema
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        case .dark:
            // Karanlık tema
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
}


