//
//  AESCredentialsWrapper.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/1/23.
//

import Foundation

func encrypt_credentials(plain_text: String, uuid: UUID) -> Data {
    return aes_encrypt(plainText: plain_text, uuid: uuid)
}

func decrypt_credentials(encrypted_data: Data, uuid: UUID) -> String {
    let out: Data = aes_decrypt(input_data: encrypted_data, uuid: uuid)
    
    let str = String(decoding: out, as: UTF8.self)
    
    return str
}
