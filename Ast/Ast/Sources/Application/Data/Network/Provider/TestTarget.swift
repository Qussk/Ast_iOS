//
//  TestTarget.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation
import Moya


enum TestTarget {
    case test(String)
}

extension TestTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .test:
            return URL(string: ServiceURL.base)!
        }
    }
    
    var path: String {
        switch self {
        case .test: return "astro/gptTest"
        }
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        
        switch self {
        case let .test(ms) :
            parameters["message"] = ms
//            return nil
        }
        return parameters
    }
    
    var headers: [String: String]? {
        switch self {
        case .test:
            return Session.shared.httpHeaders
//            return nil
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .test: return .post
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: self.parameters ?? [:], encoding: JSONEncoding.default)
//        return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.default)
    }
}
