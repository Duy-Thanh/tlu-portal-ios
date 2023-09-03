//
//  LoadingView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/1/23.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {
    // This variable is most important to trigger view to show or close
    @Binding var isShowing: Bool
    var content: () -> Content
    
    // Will set the title for the View
    var title: String?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                HStack {
                    LottieKitView(loopMode: .loop, imageName: "loading_view")
                        .scaleEffect(0.2)
                        .frame(width: 30, height: 30)
                        .padding()
                    
                    Spacer().frame(width: 10)
                    
                    Text(title ?? "Loading......")
                        .bold()
                        .font(.system(size: 20))
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 8)
                .background(Color.secondary.colorInvert()
                    .blur(radius: 20, opaque: true)
                )
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
        .transition(.scale)
    }
}
