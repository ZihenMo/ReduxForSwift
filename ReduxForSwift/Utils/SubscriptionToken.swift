//
//  SubscriptionToken.swift
//
//  Created by vino on 2024/2/23.
//

import Foundation
import Combine

class SubscriptionToken {
    var cancellable: AnyCancellable?
    
    func unseal() {
        cancellable = nil
    }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}
