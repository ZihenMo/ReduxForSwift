//
//  AppError.swift
//  Pokemon
//
//  Created by vino on 2024/2/23.
//

import Foundation

enum LoginError: Error, Identifiable {
    var id: String { localizedDescription }
    
    case emailError
    case passwordError
}

extension LoginError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .emailError:
            return "邮箱不存在或格式错误"
        case .passwordError:
            return "密码错误"
        }
    }
}
