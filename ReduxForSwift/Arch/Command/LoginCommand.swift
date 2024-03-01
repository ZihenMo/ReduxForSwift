//
//  LoginCommand.swift
//
//  Created by vino on 2024/2/23.
//

import Foundation
import Combine

struct LoginCommand: AppCommand {
    let email: String
    let password: String
    
    /// 订阅持有说明
    /// 1. token是局部变量，执行完excite方法理应释放；
    /// 2. sink之后创建了一个AnyCancellable对象，该对象表示整个订阅链，且在释放时自动调用cancel方法取消订阅；
    /// 3. seal(in:)将token的属性设为AnyCancellable对象，即持有订阅链；
    /// 4. 最关键的是token.unseal的调用让sink闭包持有了token，让token的生命延长至闭包调用完成；
    /// * 实际上，unseal方法里面的代码无关紧要，因为只要token释放了，作为其属性的AnyCancellable对象也会释放。
    func excute(in store: Store) {
        // 用于维持订阅事件的引用
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password).publisher
            .sink { completion in
                if case .failure(let error) = completion {
                    store.dispatch(.loginDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: { user in
                store.dispatch(.loginDone(result: .success(user)))
            }
            .seal(in: token)
    }
}

///// 不使用SubscriptionToken维持订阅的情况下
///// 将订阅维护到Command自身的生命周期，同时需要外部维持引用LoginCommand对象
//class LoginCommand2: AppCommand {
//    let email: String
//    let password: String
//    
//    var excuteTask: AnyCancellable?
//    
//    init(email: String, password: String) {
//        self.email = email
//        self.password = password
//    }
//    
//    func excute(in store: Store) {
//        excuteTask = LoginRequest(email: email, password: password).publisher
//            .sink { completion in
//                if case .failure(let error) = completion {
//                    // dispatch error to store
//                    store.dispatch(.loginDone(result: .failure(error)))
//                }
//            } receiveValue: { user in
//                store.dispatch(.loginDone(result: .success(user)))
//            }
//    }
//}
