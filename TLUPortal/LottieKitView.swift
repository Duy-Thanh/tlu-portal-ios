//
//  LottieKitView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import Foundation
import Lottie
import SwiftUI

struct LottieKitView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let imageName: String
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: imageName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // DO NOTHING
    }
}
