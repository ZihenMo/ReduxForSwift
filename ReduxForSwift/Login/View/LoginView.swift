//
//  LoginView.swift
//  ReduxForSwift
//
//  Created by vino on 2024/2/28.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: Store
    
    var state: LoginState { store.loginState }
    var stateBinding: Binding<LoginState> { $store.loginState }

    var body: some View {
        Form {
            if state.user != nil {
                userInfoSection
                logoutSection
            } else {
                accountSection
            }
        }
    }
    
    var accountSection: some View {
        Section("登录") {
            TextField("电子邮箱", text: stateBinding.email, prompt: Text(state.lastLogoutEmail ?? "电子邮箱"))
                .textContentType(.emailAddress)
            SecureField("密码", text: stateBinding.password)
            loginButton
        }
    }
    
    var loginButton: some View {
        Button {
            self.store.dispatch(LoginAction.login(
                email: state.email,
                password: state.password
            ))
        } label: {
            HStack {
                Text("登录")
                if state.requesting {
                    ActivityIndicatorView(isAnimating: stateBinding.requesting)
                }
            }
        }
        .font(.system(size: 16))
        .fontWeight(.semibold)
        .foregroundColor(.white)
        .frame(minWidth: 80, maxWidth: .infinity, minHeight: 30)
        .background(Capsule(style: .circular)
            .fill(Color.green)
        )
    }
    
    
    var userInfoSection: some View {
        Section("用户") {
            Text(state.user?.email ?? "")
        }
    }
    
    var logoutSection: some View {
        Button("登出") {
            guard let user = state.user else { return }
            self.store.dispatch(LoginAction.logout(user: user))
        }
        .foregroundColor(.red)
    }
    
//    var cleanCacheSection: some View {
//        Button("清除缓存") {
//            
//        }
//        .foregroundColor(.red)
//    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Store())
    }
}
