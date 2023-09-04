//
//  sha512.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import Foundation
import CryptoKit

func sha256(str_input: String) -> String? {
    let inputData = Data(str_input.utf8)
    let hashed = SHA256.hash(data: inputData)
    
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}

func sha384(str_input: String) -> String? {
    let inputData = Data(str_input.utf8)
    let hashed = SHA384.hash(data: inputData)
    
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}

func sha512(str_input: String) -> String? {
    let inputData = Data(str_input.utf8)
    let hashed = SHA512.hash(data: inputData)
    
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}

func generate_hash(str_input: String) -> String? {
    let sha256_str = sha256(str_input: str_input)!
    let sha384_str = sha384(str_input: sha256_str)!
    let complete_hash = sha512(str_input: sha384_str)!
    
    return complete_hash
}

func compare_hash(hash1: String, hash2: String) -> Bool {
    return hash1 == hash2
}
