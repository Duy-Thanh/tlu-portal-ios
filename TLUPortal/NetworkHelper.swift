//
//  ActivityIndicatorExtension.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import Foundation
import Network

final class NetworkHelperMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        
        monitor.start(queue: queue)
    }
}
