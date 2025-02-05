//
//  TestTarget.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation
import Moya


enum TestTarget {
    case test
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
        case .test: return "astro/jsonTest"
        }
    }
    
    var parameters: [String: Any]? {
        let parameters = [String: Any]()
        
        switch self {
        case .test:
//            parameters["limit"] = limit
//            parameters["page"] = page
            return nil
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
        case .test: return .get
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.default)
    }
}
