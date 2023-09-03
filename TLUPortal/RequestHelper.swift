//
//  RequestHelper.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import Foundation
import SwiftUI

func loginAPI(login: TLUPortalPublishedVariables, completion: @escaping (String?) -> Void) async {
#if DEBUG
    print("user_login: \(login.username)")
    print("user_password: \(login.password)")
#endif
    
    let client_id = "&client_id=education_client"
    let grant_type = "&grant_type=password"
    let client_secret = "&client_secret=password"
    
    // Variables
    let username = "&username=\(login.username)"
    let password = "&password=\(login.password)"
    
    let body_url = client_id + grant_type + username + password + client_secret
    let finalBody = body_url.data(using: .utf8)
    
    guard let url = URL(string: "https://sinhvien1.tlu.edu.vn:8098/education/oauth/token") else { return }
    
#if DEBUG
    print(body_url)
#endif
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.httpBody = finalBody
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        if let error = error {
#if DEBUG
            print("Request error: \(error)")
#endif
            
            SwiftErrorReturn = error.localizedDescription
            completion(error.localizedDescription)
            return
        }
        
        guard response is HTTPURLResponse else {
            if let error = error {
#if DEBUG
                print("Response error: \(error)")
#endif
                
                SwiftErrorReturn = error.localizedDescription
                completion(error.localizedDescription)
            }
            
            return
        }
        
        guard let data = data else {
            if let error = error {
#if DEBUG
                print("Response error: \(error)")
#endif
                
                SwiftErrorReturn = error.localizedDescription
                completion(error.localizedDescription)
            }
            
            return
        }
        
#if DEBUG
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
#endif
        
        DispatchQueue.main.async {
            do {
                login.login_info?.accessToken = ""
                login.login_info?.expiresIn = 0
                login.login_info?.refreshToken = ""
                login.login_info?.tokenType = ""
                login.login_info?.scope = ""
                
                let portalLogin = try JSONDecoder().decode(PortalLogin.self, from: data)
                
                // Set the environment variable login_info equal to portalLogin
                // so that our ContentView can access correct value
                login.login_info = portalLogin
#if DEBUG
                print("Access Token: \(portalLogin.accessToken)")
                print("Token Type: \(portalLogin.tokenType)")
                print("Refresh Token: \(portalLogin.refreshToken)")
                print("Expires In: \(portalLogin.expiresIn)")
                print("Scope: \(portalLogin.scope)")
#endif
            } catch {
                if let error = error as? DecodingError {
#if DEBUG
                    print("Decoding error: \(error)")
#endif
                    
                    completion(error.errorDescription)
                } else {
#if DEBUG
                    print("Error: \(error)")
#endif
                    
                    completion(error.localizedDescription)
                }
                
                do {
                    let error_login = try JSONDecoder().decode(PortalLogin_Error.self, from: data)
                    SwiftErrorReturn = error.localizedDescription
                    
                    print("Swift error: \(SwiftErrorReturn)")
                    print("Server response status: \(error_login.APIErrorReturn)")
                    print("Server error description: \(error_login.APIErrorReturnDesc)")
                    
                    completion("\(error_login.APIErrorReturn)")
                } catch {
                    print("Error: \(error)")
                    completion(error.localizedDescription)
                }
            }
        }
    }.resume()
}

func fetchUserInfo(login: TLUPortalPublishedVariables, completion: @escaping (String?) -> Void) {
    let access_token = login.login_info?.accessToken
    
//    // Variables
//    let body_url = "?access_token=" + access_token
//    let finalBody = body_url.data(using: .utf8)
//    
//    guard let url = URL(string: "https://sinhvien1.tlu.edu.vn:8098/education/api/users/getCurrentUser") else { return }
//    
//#if DEBUG
//    print(body_url)
//#endif
//    
//    var urlRequest = URLRequest(url: url)
//    urlRequest.httpMethod = "POST"
//    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
//    urlRequest.httpBody = finalBody
//    
//    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//        if let error = error {
//#if DEBUG
//            print("Request error: \(error)")
//#endif
//            
//            SwiftErrorReturn = error.localizedDescription
//            completion(error.localizedDescription)
//            return
//        }
//        
//        guard response is HTTPURLResponse else {
//            if let error = error {
//#if DEBUG
//                print("Response error: \(error)")
//#endif
//                
//                SwiftErrorReturn = error.localizedDescription
//                completion(error.localizedDescription)
//            }
//            
//            return
//        }
//        
//        guard let data = data else {
//            if let error = error {
//#if DEBUG
//                print("Response error: \(error)")
//#endif
//                
//                SwiftErrorReturn = error.localizedDescription
//                completion(error.localizedDescription)
//            }
//            
//            return
//        }
//        
//#if DEBUG
//        if let responseString = String(data: data, encoding: .utf8) {
//            print(responseString)
//        }
//#endif
//        
//        DispatchQueue.main.async {
//            do {
//                login.login_info?.accessToken = ""
//                login.login_info?.expiresIn = 0
//                login.login_info?.refreshToken = ""
//                login.login_info?.tokenType = ""
//                login.login_info?.scope = ""
//                
//                let portalLogin = try JSONDecoder().decode(PortalLogin.self, from: data)
//                
//                // Set the environment variable login_info equal to portalLogin
//                // so that our ContentView can access correct value
//                login.login_info = portalLogin
//#if DEBUG
//                print("Access Token: \(portalLogin.accessToken)")
//                print("Token Type: \(portalLogin.tokenType)")
//                print("Refresh Token: \(portalLogin.refreshToken)")
//                print("Expires In: \(portalLogin.expiresIn)")
//                print("Scope: \(portalLogin.scope)")
//#endif
//            } catch {
//                if let error = error as? DecodingError {
//#if DEBUG
//                    print("Decoding error: \(error)")
//#endif
//                    
//                    completion(error.errorDescription)
//                } else {
//#if DEBUG
//                    print("Error: \(error)")
//#endif
//                    
//                    completion(error.localizedDescription)
//                }
//                
//                do {
//                    let error_login = try JSONDecoder().decode(PortalLogin_Error.self, from: data)
//                    SwiftErrorReturn = error.localizedDescription
//                    
//                    print("Swift error: \(SwiftErrorReturn)")
//                    print("Server response status: \(error_login.APIErrorReturn)")
//                    print("Server error description: \(error_login.APIErrorReturnDesc)")
//                    
//                    completion("\(error_login.APIErrorReturn)")
//                } catch {
//                    print("Error: \(error)")
//                    completion(error.localizedDescription)
//                }
//            }
//        }
//    }.resume()
}
