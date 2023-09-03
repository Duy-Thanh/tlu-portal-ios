//
//  SplashView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var monitor = NetworkHelperMonitor()
    
    @State private var showLoading: Bool = false
    
    @State private var notConnected: Bool = false // true -> not connected; false -> connected
    
    @State private var switchToLoginView: Bool = false
    
    private func delayAsync(time: Float) async {
        if switchToLoginView {
            switchToLoginView.toggle()
        }
        
        // Delay of seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: UInt64(time) * 1_000_000_000)
    }
    
    var body: some View {
        VStack() {
            if showLoading {
                LottieKitView(loopMode: .loop, imageName: "loading_view")
                    .scaleEffect(0.5)
                    .isHidden(!showLoading, remove: !showLoading)
            }
            
            if notConnected {
                LottieKitView(loopMode: .playOnce, imageName: "lost_connection")
                    .scaleEffect(1)
                    .frame(width: 100, height: 150)
                Text("Network is not connected. Please check your internet connection then try again")
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
            if switchToLoginView {
                LoginView().transition(.opacity)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showLoading.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if monitor.isConnected {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showLoading.toggle()
                        switchToLoginView.toggle()
                    }
                } else {
                    showLoading.toggle()
                    notConnected.toggle()
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
