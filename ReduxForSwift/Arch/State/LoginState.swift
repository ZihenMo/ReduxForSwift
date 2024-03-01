//
//  AppState.swift
//
//  Created by vino on 2024/2/22.
//

import Foundation
import SwiftUI

struct LoginState {
    var email = ""
    var password = ""
    var verifyPassword = ""
    
    /// 纯副作用
    @FileStorage(directory: .documentDirectory, fileName: "user.json")
    var user: User? 
    
    @UserDefaultsStorage(keyName: "lastLogoutEmail")
    var lastLogoutEmail: String?
    
    var requesting = false
    var loginError: LoginError?
    var isPresentedAlert: Bool {
        get { loginError != nil }
        set { loginError = nil }
    }
}
