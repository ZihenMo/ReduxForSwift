//
//  ContentView.swift
//  ReduxForSwift
//
//  Created by vino on 2024/2/28.
//

import SwiftUI

struct ContentView: View {
    
    @State var gesture = ""
    @State var count = 0
    var body: some View {
        LoginView()
            .environmentObject(Store())
    	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
