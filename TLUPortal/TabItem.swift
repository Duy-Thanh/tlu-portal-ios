//
//  TabItem.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import Foundation
import TabBar

enum Item: Int, Tabbable {
    var title: String {
        switch self {
        case .first: return "Main menu"
            
        case .second: return "Account"
        }
    }
    
    case first = 0
    case second
    
    var icon: String {
        switch self {
        case .first: return "list.dash"
        case .second: return "person.crop.circle"
        }
    }
}
