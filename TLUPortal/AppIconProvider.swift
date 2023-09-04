//
//  AppIconProvider.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import Foundation

enum AppIconProvider {
    static func appIcon(in bundle: Bundle = .main) -> String {
        guard let icons = bundle.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = icons["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last else {
            print("Failed to retrieve icons")
            return ""
        }
        return iconFileName
    }
}
