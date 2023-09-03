//
//  UserInfoView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import SwiftUI

struct UserInfoView: View {
    /**
        * UNCOMMENT WHEN RELEASE!!
     */
    
    /* let login_struct: <LoginStruct> */
    
    private enum Field: Int, CaseIterable {
        case firstName
        case lastName
        case fullName
        case dateOfBirth
    }
    
    var imageName: String?
    
    @FocusState private var focusedField: Field?
    
    @State private var buttonPressed: Bool = false
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var fullName: String = ""
    @State private var dateOfBirth: String = ""
    @State private var genderSelection: String = "Male"
    
    @State private var labelHeight = CGFloat.zero
    
    @StateObject var gender_object = TLUPortalPublishedVariables()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        // User image
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.blue)
                            .padding()
                        
                        Spacer().frame(height: 28)
                        
                        // HStack for first name and last name
                        HStack {
                            // First name
                            VStack {
                                // First name label
                                HStack {
                                    Spacer().frame(width: 18)
                                    
                                    // First name user input
                                    Text("First Name")
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxHeight: .infinity)
                                }
                                .frame(height: 10)
                                
                                TextField(text: $firstName, prompt: Text("First name")) {
                                    Text("First name")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .textFieldStyle(TextFieldStyleCustom())
                                .focused($focusedField, equals: .firstName)
                                .padding(12)
                                .frame(width: 210)
                                .toolbar {
                                    // Show hide keyboard button
                                    ToolbarItem(placement: .keyboard) {
                                        Button(action: {
                                            focusedField = nil
                                        }) {
                                            Image(systemName: "keyboard.chevron.compact.down")
                                        } // End of ToolBar->Button
                                    } // End of ToolBarItem
                                }
                            }
                            
                            VStack {
                                // Last name label
                                HStack {
                                    Spacer().frame(width: 4)
                                    
                                    Text("Last name")
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxHeight: .infinity)
                                        .padding(12)
                                }
                                .frame(height: 10)
                                
                                // Last name user input
                                TextField(text: $lastName, prompt: Text("Last name")) {
                                    Text("Last name")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .textFieldStyle(TextFieldStyleCustom())
                                .focused($focusedField, equals: .lastName)
                                .padding(12)
                                .frame(width: 210)
                            }
                        }
                        
                        Spacer().frame(height: 20)
                        
                        // Full name
                        VStack {
                            // Full name label
                            
                            HStack {
                                Spacer().frame(width: 4)
                                
                                Text("Full name")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(maxHeight: .infinity)
                                    .padding(12)
                            }
                            .frame(height: 10)
                            
                            TextField(text: $fullName, prompt: Text("Full name")) {
                                Text("Full name")
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .textFieldStyle(TextFieldStyleCustom())
                            .focused($focusedField, equals: .fullName)
                            .padding(12)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        HStack {
                            // Gender label
                            
                            HStack {
                                Spacer().frame(width: 4)
                                
                                Text("Gender: ")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(maxHeight: .infinity)
                                    .frame(maxWidth: .infinity)
                                    .padding(12)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            
                            // Last name user input
                            DropDownMenuListCustom(genderObject: gender_object)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer().frame(height: 21)
                        
                        // Date of birth
                        VStack {
                            // Date of birth label
                            
                            HStack {
                                Spacer().frame(width: 4)
                                
                                Text("Date of birth: ")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(maxHeight: .infinity)
                                    .padding(12)
                                    .frame(height: 16)
                            }
                            .frame(height: 10)
                            
                            Spacer().frame(height: 20)
                            
                            // Date of birth
                            TextField(text: $dateOfBirth, prompt: Text("Date of birth")) {
                                Text("Date of birth")
                            }
                            .frame(maxWidth: .infinity, maxHeight: 28)
                            .textFieldStyle(TextFieldStyleCustom())
                            .focused($focusedField, equals: .dateOfBirth)
                            .padding(12)
                        }

                    }
                } // End of ScrollView
            } // End if VStack
        } // End of NavigationView
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
