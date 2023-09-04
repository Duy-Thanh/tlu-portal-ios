//
//  MainView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 8/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var PortalLogin_Informations: TLUPortalPublishedVariables
    
    @EnvironmentObject var tabSelection: TLUPortalPublishedVariables // Use @EnvironmentObject directly
    
    @State private var buttonPressed: Bool = false
    
    @State private var animateGradient = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .purple, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer().frame(width: 20)
                        
                        Button(action: {
                            buttonPressed.toggle()
                        }) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                        
                        Text("Welcome back!")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .frame(height: 18)
                    }
                    .padding(6)
                    
                    Spacer().frame(height: 20)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Group {
                                // Row 1
                                VStack {
                                    HStack {
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 200)
                                        
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(width: 200)
                                    }
                                }
                                
                                // Row 2
                                VStack {
                                    HStack {
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 200)
                                        
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(width: 200)
                                    }
                                }
                                
                                // Row 3
                                VStack {
                                    HStack {
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 200)
                                        
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(width: 200)
                                    }
                                }
                                
                                // Row 4
                                VStack {
                                    HStack {
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 200)
                                        
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(width: 200)
                                    }
                                }
                                
                                // Row 5
                                VStack {
                                    HStack {
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 200)
                                        
                                        Button("Press me") {
                                            print("")
                                        }
                                        .buttonStyle(CustomButton(imageName: "circle"))
                                        .cornerRadius(20)
                                        .padding(5)
                                        .frame(width: 200)
                                    } // End of HStack
                                } // End of VStack row 5
                            } // End of group
                        } // End of ScrollView
                    } // End of VStack
                    .sheet(isPresented: $buttonPressed) {
                        NavigationView {
                            // Add image into UserInfoView()
                            UserInfoView().environmentObject(TLUPortalPublishedVariables())
                                .navigationBarTitle("Account")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarItems(trailing: Button(action: {
                                    buttonPressed = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                    .buttonStyle(CloseButtonStyleCustom())
                                )
                        } // End of NavigationView of sheet
                    } // End of .sheet()
                } // End of ZStack()
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            } // End of NavigationView
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TLUPortalPublishedVariables())
    }
}
