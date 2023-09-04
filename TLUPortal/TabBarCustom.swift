//
//  TabBarCustom.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import SwiftUI
import TabBar

struct CustomTabBarStyle: TabBarStyle {
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .background(Color(.white))
            .cornerRadius(25.0)
            .frame(height: 50.0)
            .padding(.horizontal, 64.0)
            .padding(.bottom, 16.0 + geometry.safeAreaInsets.bottom)
    }
}
