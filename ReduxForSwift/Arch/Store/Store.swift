//
//  Store.swift
//
//  Created by vino on 2024/2/22.
//

import Foundation
import Combine

//class Store<State>: ObservableObject {
//  @Published private(set) var state: State
//
//  init(initial: State) {
//    self.state = initial
//  }
//}

class Store: ObservableObject {
    @Published var loginState = LoginState()
    
    func dispatch(_ action: LoginAction) {
        debugPrint("[Action]:\(action)")
        let result = Self.reduce(state: loginState, action: action)
        loginState = result.state
        if let command = result.cmd {
            debugPrint("[Command]:\(command)")
            command.excute(in: self)
        }
    }
}

extension Store {
    static func reduce(state: LoginState, action: LoginAction) -> (state: LoginState, cmd: AppCommand?) {
        var loginState = state
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            guard !loginState.requesting else {
                break
            }
            loginState.requesting = true
            appCommand = LoginCommand(email: email, password: password)
        case .loginDone(result: let result):
            loginState.requesting = false
            switch result {
            case .success(let user):
                loginState.user = user
            case .failure(let error):
                loginState.loginError = error
            }
        case .logout(let user):
            loginState = LoginState()
            loginState.lastLogoutEmail = user.email
            loginState.user = nil
        }
        return (state: loginState, cmd: appCommand)
    }
}
