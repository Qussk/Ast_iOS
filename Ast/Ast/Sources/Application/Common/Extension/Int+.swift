//
//  Int+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import Foundation


extension Int {
    func getTopRank(default: Bool) -> String {
        switch self {
        case 1 : return "🥇"
        case 2 : return "🥈"
        case 3 : return "🥉"
        default :
            return `default` ? "🌟" : ""
        }
    }
    func toString() -> String {
        return String(describing: self)
    }
}
