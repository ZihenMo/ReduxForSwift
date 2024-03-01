//
//  ActivityIndicatorView.swift
//  Pokemon
//
//  Created by vino on 2024/2/23.
//

import Foundation
import UIKit
import SwiftUI

struct ActivityIndicatorView: View, UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
        uiView.isHidden = !isAnimating
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    @State static var isAnimating = true
    static var previews: some View {
        ActivityIndicatorView(isAnimating: $isAnimating)
    }
}
