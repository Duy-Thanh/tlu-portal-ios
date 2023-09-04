//
//  PDFUIViewer.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import SwiftUI

struct PDFUIViewer: View {
    // Custom navigation bar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var title_name: String
    var document_name: String
    
    init(title_name: String, document_name: String) {
        self.title_name = title_name
        self.document_name = document_name
        self._zoomScale = State(initialValue: 1.0)
    }
    
    var pdfURL: URL? { Bundle.main.url(forResource: document_name, withExtension: "pdf")
    }
    
    // Default scale density
    @GestureState private var scale: CGFloat = 1.0
    @State private var zoomScale: CGFloat = 1.0
    
    // Auto scroll to top when the view appear
    @State private var scrollToTop: Bool = false
    
    // Animation
    @State private var animateGradient = false
    
    // Limit of scale to prevent infinity scale
    private var minScale: CGFloat = 1.0
    private var maxScale: CGFloat = 5.0
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
            }
        }
    }
    
    var title : some View {
        return Group {
            Text(title_name)
                .fontWeight(.bold)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea()
            
            VStack {
                GeometryReader { geometry in
                    PDFKitView(url: pdfURL!, scrollToTop: $scrollToTop)
                        .scaleEffect(scale)
                        .onAppear {
                            scrollToTop = true
                        }
                        .gesture(
                            MagnificationGesture()
                                .updating($scale) { value, gestureState, _ in
                                    gestureState = value.magnitude
                                }
                                .onChanged { value in
                                    let newScale = zoomScale * value.magnitude
                                    
                                    zoomScale = min(maxScale, max(minScale, newScale))
                                }
                        )
                        .edgesIgnoringSafeArea(.bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                } // End of GeometryReader
            } // End of VStack
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    btnBack
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .principal) {
                    title
                        .foregroundColor(.white)
                }
            }
        }.onAppear {
            withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

struct PDFUIViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFUIViewer(title_name: "User Manual", document_name: "UserGuide")
    }
}
