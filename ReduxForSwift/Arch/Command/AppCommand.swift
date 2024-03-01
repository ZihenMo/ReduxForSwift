//
//  AppCommand.swift
//
//  Created by vino on 2024/2/23.
//  处理副作用

import Foundation
import Combine


protocol AppCommand {
    func excute(in store: Store)
}
