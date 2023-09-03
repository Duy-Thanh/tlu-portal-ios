//
//  PublishedVariables.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import Foundation

class TLUPortalPublishedVariables: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var login_info: PortalLogin?
    @Published var selection: Tab = .MainMenu
    
    @Published var selection_gender: String = "Male"
}
