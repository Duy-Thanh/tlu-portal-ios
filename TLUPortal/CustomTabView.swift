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
    
    @EnvironmentObject var selectionObject:  TLUPortalPublishedVariables
    
    var body: some View {
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
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .environmentObject(TLUPortalPublishedVariables())
    }
}
