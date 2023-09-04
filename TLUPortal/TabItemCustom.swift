//
//  TabItemCustom.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import SwiftUI
import TabBar

struct CustomTabItemStyle: TabItemStyle {
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        ZStack {
            if isSelected {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 40.0, height: 40.0)
            }
            
            Image(systemName: icon)
                .foregroundColor(isSelected ? .white : Color(.black))
                .frame(width: 32.0, height: 32.0)
        }
        .padding(.vertical, 8.0)
    }
    
}
