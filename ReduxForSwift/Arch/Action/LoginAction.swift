//
//  AppAction.swift
//
//  Created by vino on 2024/2/22.
//

import Foundation

enum LoginAction {
    case login(email: String, password: String)
    case loginDone(result: Result<User, LoginError>)
    case logout(user: User)
}
