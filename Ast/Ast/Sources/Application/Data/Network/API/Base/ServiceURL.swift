//
//  ServiceURL.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation


struct ServiceURL {
//    struct ServiceURLAPIPath {
//        static let v1 = "v1"
//    }
//    
//    static var apiPath: ServiceURLAPIPath.Type {
//        return ServiceURLAPIPath.self
//    }

    static let base = "http://192.168.219.100:8080"
}

struct WebURL {
    static let base = "https://qussk.notion.site"
    
    struct WebPath {
        static let personal = "1923eac0bcd080fc802ef9531783ff3d"
        static let marketing =  "1923eac0bcd080bc92fcf35f62ff1724"
    }
    
    struct WebAPIPath {
        let notion = "pvs=4"
    }
    static var webPath: WebPath.Type {
        return WebPath.self
    }
    
    static var apiPath: WebAPIPath.Type {
        return WebAPIPath.self
    }
    
    static let isPersonal = "\(Self.base)/\(Self.webPath.personal)?\(Self.apiPath)"
    static let isMarketing = "\(Self.base)/\(Self.webPath.marketing)?\(Self.apiPath)"
}
