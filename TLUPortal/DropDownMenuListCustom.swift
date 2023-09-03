//
//  DropDownMenuListCustom.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/7/23.
//

import Foundation
import SwiftUI

public struct DropDownMenuListCustom: View {
    //@Binding var selection: String
    //@State var selectionList = [String]()
    @State var expand = false
    @StateObject var genderObject = TLUPortalPublishedVariables()
    
    public var body: some View {
        VStack() {
            VStack() {
                HStack {
                    Text("Select Gender")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 12, height: 6)
                        .foregroundColor(.black)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    Button(action: {
                        print("Male")
                        self.expand.toggle()
                    }) {
                        Text("Male")
                            .padding()
                    }
                    
                    Button(action: {
                        print("Female")
                        self.expand.toggle()
                    }) {
                        Text("Female")
                            .padding()
                    }
                }
            }
        }
    }
}
