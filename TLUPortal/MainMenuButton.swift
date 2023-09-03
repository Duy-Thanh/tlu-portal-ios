//
//  MainMenuButton.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import Foundation
import SwiftUI

struct CustomButton: ButtonStyle {
    let imageName: String
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 80, height: 80)
            
            configuration.label
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 280)
        .padding()
        .background(Color.accentColor)
    }
}
