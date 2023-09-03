//
//  FileManager.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/1/23.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
}

func stringWrite(fileName: String, string_to_write: String) {
    let url_appended = getDocumentsDirectory().appendingPathComponent(fileName)
    
    do {
        try string_to_write.write(to: url_appended, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
}

func stringRead(fileName: String) -> String {
    let url_appended = getDocumentsDirectory().appendingPathComponent(fileName)
    
    do {
        return try String(contentsOf: url_appended)
    } catch {
        print(error.localizedDescription)
        
        return ""
    }
}

func dataWrite(fileName: String, data_to_write: Data) {
    let url_appended = getDocumentsDirectory().appendingPathComponent(fileName)
    
    do {
        try data_to_write.write(to: url_appended)
    } catch {
        print(error.localizedDescription)
    }
}

func dataRead(fileName: String) -> Data {
    let url_appended = getDocumentsDirectory().appendingPathComponent(fileName)
    
    do {
        return try Data(contentsOf: url_appended)
    } catch {
        print(error.localizedDescription)
        
        return Data()
    }
}
