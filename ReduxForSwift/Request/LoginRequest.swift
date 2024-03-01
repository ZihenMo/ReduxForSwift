//
//  LoginRequest.swift
//  Pokemon
//
//  Created by vino on 2024/2/23.
//

import Foundation
import Combine

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, LoginError> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                let isValidEmail = self.email.hasSuffix(".com")
                let isValidPassword = self.password == "123456"
                if isValidEmail && isValidPassword {
                    promise(.success(User(email: self.email)))
                } else if !isValidPassword {
                    promise(.failure(.passwordError))
                } else {
                    promise(.failure(.emailError))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
