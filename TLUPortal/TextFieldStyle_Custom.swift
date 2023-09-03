//
//  TextFieldStyle_Custom.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 12/07/2023.
//

import Foundation
import SwiftUI

struct TextFieldStyleCustom: TextFieldStyle {
    @Environment(\.colorScheme) var currentColor
    
    var color: Color {
        if currentColor == .light {
            return Color.black
        } else {
            return Color.white
        }
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View { configuration
        .padding(12)
        .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(color, lineWidth: 1)
        )
    }
}
