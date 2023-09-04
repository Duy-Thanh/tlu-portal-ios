//
//  CloseButtonStyle.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/7/23.
//

import Foundation
import SwiftUI

struct CloseButtonStyleCustom: ButtonStyle {
    @Environment (\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: "xmark.circle")
            .foregroundColor(.white)
    }
}
