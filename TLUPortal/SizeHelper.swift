//
//  SizeHelper.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import Foundation
import Combine
import SwiftUI

struct Size: PreferenceKey {
    typealias Value = [CGRect]
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}
