//
//  CustomTabView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import SwiftUI

struct CustomTabView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var buttonPressed: Bool = false
    
    @State private var animateGradient = false
    
    @State var playerFrame = CGRect.zero
    
    @EnvironmentObject var selectionObject:  TLUPortalPublishedVariables
    
    var body: some View {
        ZStack {
            TabView(selection: $selectionObject.selection) {
                MainView()
                    .environmentObject(TLUPortalPublishedVariables())
                    .tabItem {
                        Label("Main menu", systemImage: "list.dash")
                    }
                    .disableSwipeBack()
                    .tag(Tab.MainMenu)
                
                UserInfoView()
                    .environmentObject(TLUPortalPublishedVariables())
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle")
                    }
                    .disableSwipeBack()
                    .tag(Tab.UserInfo)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .disableSwipeBack()
            .onPreferenceChange(Size.self, perform: { (v) in
                self.playerFrame = v.last ?? .zero
                print(self.playerFrame)
            }) // End TabView
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .environmentObject(TLUPortalPublishedVariables())
    }
}
