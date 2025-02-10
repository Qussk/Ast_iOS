//
//  WebViewRepresentable.swift
//  Ast
//
//  Created by 변윤나 on 2/9/25.
//

import Foundation
import SwiftUI
import Combine
import WebKit
import ComposableArchitecture

// MARK: - WebViewCommonUI

struct WebViewRepresentable: UIViewRepresentable {
    @State var urlString : String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: setConfiguration())
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = true
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        
        let urlString = urlString
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func setConfiguration() -> WKWebViewConfiguration{
        let configuration = WKWebViewConfiguration()
        configuration.preferences = setPreferences()
        configuration.allowsInlineMediaPlayback = true
        return configuration
    }
    
    func setPreferences() -> WKPreferences {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        return preferences
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject {
        var parent: WebViewRepresentable
        var isAutoTitleChange: Bool = false
        
        init(_ webView: WebViewRepresentable) {
            self.parent = webView
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebViewRepresentable.Coordinator: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let script = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
}
