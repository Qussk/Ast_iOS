//
//  Session.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation


final class Session {
    static let shared = Session()
    var httpHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
}

