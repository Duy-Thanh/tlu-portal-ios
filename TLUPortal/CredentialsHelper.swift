////
////  CredentialsHelper.swift
////  TLUPortal
////
////  Created by Thành Duy Nguyễn on 12/07/2023.
////
//
import Foundation
import UIKit
import RNCryptor

import AuthenticationServices

// Save our data into Keychain
func save(login_vars: TLUPortalPublishedVariables, completion: @escaping (String?) -> Void) {
    let username = login_vars.username
    let password = login_vars.password.data(using: .utf8)!

    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecValueData as String: password
    ]

    if SecItemAdd(attributes as CFDictionary, nil) == noErr {
        completion("Done")
    } else {
        completion("Failed")
    }
}

// Update our data in Keychain
func update(login_vars: TLUPortalPublishedVariables, completion: @escaping (String?) -> Void) {
    let username = login_vars.username
    let password = login_vars.password.data(using: .utf8)!

    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
    ]

    let updatedData: [String: Any] = [kSecValueData as String: password]

    if SecItemUpdate(attributes as CFDictionary, updatedData as CFDictionary) == noErr {
        completion("Done")
    } else {
        completion("Failed")
    }
}

// Read our data in Keychain
func read(login_vars: TLUPortalPublishedVariables, completion: @escaping (String?) -> Void) {
    let username = login_vars.username

    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnAttributes as String: true,
        kSecReturnData as String: true
    ]

    var result: CFTypeRef?
    let status = SecItemCopyMatching(attributes as CFDictionary, &result)

    if status == errSecSuccess, let item = result as? [String: Any],
       let passwordData = item[kSecValueData as String] as? Data,
       let password = String(data: passwordData, encoding: .utf8) {
        completion(password)
    } else {
        completion(nil)
    }
}

// Delete our data in Keychain
func delete(login_vars: TLUPortalPublishedVariables) {
    let username = login_vars.username

    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username
    ]

    SecItemDelete(attributes as CFDictionary)
}

func getUUID() -> UUID {
    return UIDevice.current.identifierForVendor!
}

func aes_encrypt(plainText: String, uuid: UUID) -> Data {
    var data: Data = plainText.data(using: String.Encoding.utf8)!
    let encryptor = RNCryptor.Encryptor(password: uuid.uuidString)
    let cipherText = NSMutableData()
    
    do {
        try cipherText.append(encryptor.update(withData: data))
        
        try cipherText.append(encryptor.finalData())
    } catch let error {
        print("\(error.localizedDescription)")
    }
    
    return cipherText as Data
}

func aes_decrypt(input_data: Data, uuid: UUID) -> Data {
    var data: Data = input_data
    let decryptor = RNCryptor.Decryptor(password: uuid.uuidString)
    let cipherText = NSMutableData()
    
    do {
        try cipherText.append(decryptor.update(withData: data))
        
        try cipherText.append(decryptor.finalData())
    } catch let error {
        print("\(error.localizedDescription)")
    }
    
    return cipherText as Data
}
