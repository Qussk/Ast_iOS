//
//  Reachability.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Moya
import Alamofire

struct NetworkMonitor {
    static let shared = NetworkMonitor()
    private let reachability = NetworkReachabilityManager()

    /// 현재 네트워크 연결 상태 확인
    func isNetworkAvailable() -> Bool {
        return reachability?.isReachable ?? false
    }
    
    /*
     Button("네트워크 확인하기") {
         isOffline = !NetworkMonitor.shared.isNetworkAvailable()
     }
     */
}
