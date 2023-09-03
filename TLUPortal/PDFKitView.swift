//
//  PDFView.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import Foundation
import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    let url: URL
    @Binding var scrollToTop: Bool
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        
        // Enable zooming
        pdfView.autoScales = true
        pdfView.isUserInteractionEnabled = true
        
        // Scroll to top up appear
        if scrollToTop {
            pdfView.goToFirstPage(nil)
            if let document = pdfView.document, let page_doc = document.page(at: 0) {
                let destination = PDFDestination(page: page_doc, at: CGPoint(x: 0, y: page_doc.bounds(for: .mediaBox).maxY))
                pdfView.go(to: destination)
            }
            
            DispatchQueue.main.async {
                scrollToTop = false
            }
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // Do nothing
    }
}
