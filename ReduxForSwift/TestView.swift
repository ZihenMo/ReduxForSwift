//
//  TestView.swift
//  ReduxForSwift
//
//  Created by vino on 2024/2/29.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            
        Text("Hello, world!")
            .previewDevice(PreviewDevice(rawValue: "iPhone Xs"))
    }
}
