//
//  WebUIFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/9/25.
//

import SwiftUI
import ComposableArchitecture
import WebKit


enum WebUIType: Equatable {
    case personal
    case marketing
}

@Reducer
struct WebUIFeature {
    struct State: Equatable {
        var title: String = ""
        var webView: WKWebView?
        var url: String = ""
        var type: WebUIType = .personal
        var isClose = false
    }
    
    enum Action: Equatable {
        case viewAppeared
        case setWebView(WKWebView)
        case close
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .setWebView(let webView):
                state.webView = webView
                return .none
            case .close :
                state.isClose = true
                return .none
            }
        }
    }
}

