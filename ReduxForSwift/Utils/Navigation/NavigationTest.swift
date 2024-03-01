//
//  NavigationTest.swift
//  ReduxForSwift
//
//  Created by vino on 2024/2/29.
//

import SwiftUI

class TestEnvironmentObject: ObservableObject {
    var name = "xiaoming"
    
    init(name: String = "xiaoming") {
        self.name = name
        debugPrint("init \(Self.self)")
    }
    
    deinit {
        debugPrint("deinit \(Self.self)")
    }
}

struct ColorDetail: View {
    var color: Color

    @EnvironmentObject var obj: TestEnvironmentObject

    var body: some View {
        color.navigationTitle(color.description)
    }
}

struct NavigationTest: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mint") { ColorDetail(color: .mint).environmentObject(TestEnvironmentObject()) }
                NavigationLink("Pink") { ColorDetail(color: .pink) }
                NavigationLink("Teal") { ColorDetail(color: .teal) }
            }
            .navigationTitle("Colors")
        }
        
    }
}

struct NavigationTest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTest()
    }
}
