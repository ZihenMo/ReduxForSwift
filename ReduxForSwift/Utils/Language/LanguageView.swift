//
//  LanguageView.swift
//  Pokemon
//
//  Created by vino on 2024/2/28.
//

import SwiftUI
import Combine

// 自定义环境变量来存储应用的当前语言设置
//private struct AppLanguageKey: EnvironmentKey {
//    static var defaultValue: String = "en" // 默认语言为英语
//}
//
//extension EnvironmentValues {
//    var appLanguage: String {
//        get { self[AppLanguageKey.self] }
//        set { self[AppLanguageKey.self] = newValue }
//    }
//
//    var isRTL: Bool {
//        appLanguage == "fr"
//    }
//}
//
//enum MyLanguage: String {
//    case en
//    case fr
//}

//// 自动适配的文本视图
//struct LocalizedText: View {
//    let key: String
//
//    var body: some View {
//        Text(LocalizedStringKey(key))
//    }
//}
//
//// 自动适配的图片视图
//struct LocalizedImage: View {
//    let systemName: String
//
//    var body: some View {
//        Image(systemName: systemName)
//    }
//}

//public let langaugeChange = Notification.Name(rawValue: "appLanguage")

class LanguageViewModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    
    @Published var appLanguage: String = "en"
    @Published var isRTL = false
    
    init() {
        $appLanguage
            .map { self.checkIsRTL($0) }
            .assign(to: &$isRTL)
    }

    func checkIsRTL(_ lang: String) -> Bool {
        appLanguage == "fr"
    }
}


struct LanguageView: View {
    @EnvironmentObject private var model: LanguageViewModel

    var body: some View {
        
        print("rtl: \(model.isRTL)")
        return VStack {
            HStack {
                Text("hello_world_key")
                Image(systemName: "heart")
            }
            Picker(selection: $model.appLanguage, label: Text("语言")) {
                Text("en").tag("en")
                Text("fr").tag("fr")
            }.pickerStyle(.menu)
        }
        .environment(\.layoutDirection, model.isRTL ? .rightToLeft : .leftToRight)
    }
}

struct LanguageView_Previews: PreviewProvider {
    @State static var appLanguage: String = "en" // 默认语言为英语
//    @Environment(\.appLanguage) private var appLanguage

    static var previews: some View {
        LanguageView()
            .environmentObject(LanguageViewModel())
//            .environment(\.appLanguage, appLanguage)
//            .onReceive(NotificationCenter.default.publisher(for: langaugeChange)) { noti in
//                print("noti:\(noti)")
//                if let lang = noti.userInfo?["lang"] as? String {
//                    appLanguage = lang
//                }
//            }
    }
}
