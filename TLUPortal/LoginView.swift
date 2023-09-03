//
//  ContentView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import SwiftUI

struct LoginView: View {
    private enum Field: Int, CaseIterable {
        case username, password
    }
    
    @StateObject var login_vars = TLUPortalPublishedVariables()
    
    @State var user = ""
    @State var pass = ""
    
    @State private var error: Bool = false
    @State private var authenticating: Bool = false
    @State private var done: Bool = false
    @State private var error_shake: Bool = false
    
    @State private var isLoadingShow: Bool = false
    
    @FocusState private var focusedField: Field?
    
    @State var secureField_tap = 0
    
    @State var invalidUsername = 0
    @State var invalidPassword = 0
    
    let uuid: UUID = getUUID()
    
    // Login action
    func login() {
        Task {
            do {
                try await loginAPI(login: login_vars) { error in
                    if let error = error {
                        SwiftErrorReturn = error.description
                    } // end `if let error`
                } // end `try await`
            } catch {
                print("Error: \(error)")
                SwiftErrorReturn = error.localizedDescription
            }
        } // end `Task`
    } // end login function
    
    // View code here
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $isLoadingShow) {
                VStack {
                    // Group Text and tutorial
                    Group {
                        Spacer()
                        
                        Text("Login")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .frame(alignment: .center)
                        
                        Spacer().frame(height: 18, alignment: .center)
                        
                        Text("Use account login to sinhvien.tlu.edu.vn\n to login this app")
                            .multilineTextAlignment(.center)
                            .fontWeight(.regular)
                            .frame(alignment: .center)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Group user input field
                    Group {
                        TextField(text: $user, prompt: Text("Username is required")) {
                            Text("Username")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .textFieldStyle(TextFieldStyleCustom())
                        .focused($focusedField, equals: .username)
                        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(invalidUsername == 0 ? Color.clear : Color.red, lineWidth: 5))
                        .modifier(ShakeEffect(animatableData: CGFloat(invalidUsername)))
                        .padding(16)
                        .toolbar {
                            // Show hide keyboard button
                            ToolbarItem(placement: .keyboard) {
                                Button(action: {
                                    focusedField = nil
                                }) {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                }
                            }
                        }
                        
                        SecureField(text: $pass, prompt: Text("Password is required")) {
                            Text("Password")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .textFieldStyle(TextFieldStyleCustom())
                        .focused($focusedField, equals: .password)
                        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(invalidPassword == 0 ? Color.clear : Color.red, lineWidth: 5))
                        .modifier(ShakeEffect(animatableData: CGFloat(invalidUsername)))
                        .padding(16)
                        .simultaneousGesture(TapGesture().onEnded {
                            if (self.secureField_tap <= 0) {
                                self.secureField_tap += 1
                                
                                login_vars.username = user
                            } else {
                                // Action
                            }
                        })
                    }
                    .frame(alignment: .center)
                    
                    Spacer().frame(height: 30)
                    
                    // Button
                    Button(action: {
                        // Login button action
                        print("Authenticating......")
                        login_vars.username = user
                        
                        login_vars.password = pass
                        
                        if (login_vars.username.isEmpty || login_vars.password.isEmpty) {
                            
                            withAnimation(.default) {
                                self.invalidUsername += 1
                                self.invalidPassword += 1
                            }
                            
                            if !error {
                                error = true
                                isLoadingShow = false
                            }
                            
                            if authenticating {
                                authenticating = false
                                isLoadingShow = false
                            }
                            
                            if done {
                                done = false
                                isLoadingShow = false
                            }
                        } else {
                            authenticating = true
                            isLoadingShow = true
                            error = false
                            done = false
                            
                            login()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                print(login_vars.login_info?.accessToken ?? "")
                                if ((login_vars.login_info?.accessToken.trimmingCharacters(in: .whitespaces) .isEmpty) == false) {
                                    withAnimation(.none) {
                                        self.invalidUsername = 0
                                        self.invalidPassword = 0
                                    }
                                    
                                    authenticating = false
                                    isLoadingShow = false
                                    error = false
                                    done = true
                                    
                                    // Encrypt here
                                    let username_encrypted = encrypt_credentials(plain_text: login_vars.username, uuid: uuid)
                                    
                                    dataWrite(fileName: "username.dat", data_to_write: username_encrypted)
                                    
                                    let password_encrypted = encrypt_credentials(plain_text: login_vars.password, uuid: uuid)
                                    
                                    dataWrite(fileName: "password.dat", data_to_write: password_encrypted)
                                } else {
                                    withAnimation(.default) {
                                        self.invalidUsername += 1
                                        self.invalidPassword += 1
                                    }
                                    
                                    authenticating = false
                                    isLoadingShow = false
                                    error = true
                                    done = false
                                }
                            }
                        }
                    }) {
                        Text(authenticating ? "LOGGING IN......" : "LOG IN")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(authenticating ? Color.green : Color.accentColor)
                    }
                    .cornerRadius(20)
                    .padding(16)
                    
                    // Show view depend on flags is set
                    if error {
                        HStack {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(Color.red)
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            
                            Text("Username or password are incorrect")
                                .foregroundColor(Color.red)
                                .font(.system(size: 15))
                        }
                    }
                    
                    if done {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.green)
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            
                            Text("You're logged in")
                                .foregroundColor(Color.green)
                                .font(.system(size: 15))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        NavigationLink(destination: PDFUIViewer(title_name: "User Manual", document_name: "UserGuide")) {
                            Text("USER MANUAL")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color.accentColor)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.accentColor, lineWidth: 1)
                                ).padding(16)
                        } // End of Button->NavigationLink
                    } // End of button
                } // End of body
            } // End of LoadingView
        } // End of NavigationView
        .onAppear {
            // Auto-fill username and password
            //
            let username_read = dataRead(fileName: "username.dat")
            
            user = decrypt_credentials(encrypted_data: username_read, uuid: uuid)
            
            let password_read = dataRead(fileName: "password.dat")
            
            pass = decrypt_credentials(encrypted_data: password_read, uuid: uuid)
        }
        .navigate(to: CustomTabView().environmentObject(TLUPortalPublishedVariables()),
                  when: $done)
    } // End of content view
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() // Show the preview
    }
}
