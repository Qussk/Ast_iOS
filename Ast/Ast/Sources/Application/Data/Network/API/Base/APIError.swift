//
//  APIError.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation


enum APIError: Error, Decodable {
    case unowned
    case parsingResponse(body: String?)
    case emptyResultData
    
    var description: String {
        switch self {
        case .parsingResponse(let body):
            return "error: \(self.localizedDescription)\n body: \(body ?? "")"
        default:
            return self.localizedDescription
        }
    }
}

