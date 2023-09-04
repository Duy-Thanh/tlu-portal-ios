//
//  DropDownMenuListCustom.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/7/23.
//

import Foundation
import SwiftUI

public struct DropDownMenuListCustom: View {
    @State var expand = false
    @StateObject var genderObject = TLUPortalPublishedVariables()
    
    public var body: some View {
        VStack() {
            VStack() {
                HStack {
                    Text(self.genderObject.selection_gender)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 12, height: 6)
                        .foregroundColor(.white)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    Button(action: {
                        print("No gender selected")
                        self.expand.toggle()
                        genderObject.selection_gender = "None"
                    }) {
                        Text("Select Gender")
                            .padding()
                    }.foregroundColor(.white)
                    
                    Button(action: {
                        print("Male")
                        self.expand.toggle()
                        genderObject.selection_gender = "Male"
                    }) {
                        Text("Male")
                            .padding()
                    }.foregroundColor(.white)
                    
                    Button(action: {
                        print("Female")
                        self.expand.toggle()
                        genderObject.selection_gender = "Female"
                    }) {
                        Text("Female")
                            .padding()
                    }.foregroundColor(.white)
                } // End of conditional
            }
            .padding()
            .background(LinearGradient(gradient: .init(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(12)
            .animation(.spring())
            .fixedSize(horizontal: true, vertical: true)
        }
    }
}
