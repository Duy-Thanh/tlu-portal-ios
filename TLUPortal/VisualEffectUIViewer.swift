//
//  CustomTabBar.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import Foundation
import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
