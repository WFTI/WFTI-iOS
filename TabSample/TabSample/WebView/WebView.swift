//
//  WebView.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/06.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    
    @ObservedObject var webViewModel: WebViewModel
    var url: String?
    var isInnerHTML: Bool?

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> WKWebView {
        let coordinator = makeCoordinator()
        let userContentController = WKUserContentController()
        userContentController.add(coordinator, name: "bridge")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let wkWebView = WKWebView(frame: .zero, configuration: configuration)
        wkWebView.navigationDelegate = coordinator
        
        return wkWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        // 내부 html 로딩 시 경로
        if let isInnerHTML = isInnerHTML, isInnerHTML == true {
            guard let url = url else { return }
            guard let path: String = Bundle.main.path(forResource: url, ofType: "html") else { return }
            let localeHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
            webView.loadFileURL(localeHTMLUrl, allowingReadAccessTo: localeHTMLUrl)
        }
        
        // 외부 웹페이지 로딩 시 경로
        if (isInnerHTML ?? false) == false {
            if let urlString = url, let url = URL(string: urlString) {
                webView.load(URLRequest(url: url))
            }
        
        }
    }
    

}

extension WebView {
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        
        var webView: WKWebView?
        var parent: WebView
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
        }
        
        // receive message from wkwebView
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            
            print(message.body)

            guard let bodyString = message.body as? String, let bodyData = bodyString.data(using: .utf8) else {
                print("Failed to parse webMessage")
                return
            }
            
            let webMessage = try? JSONDecoder().decode(WebMessage.self, from: bodyData)
            
            print(webMessage)
            
            switch(webMessage?.function) {
            case "hideWebView" :
                print("call hideWebView")
                self.hideWebView(webMessage?.val)
            case "hideMainClubView" :
                print("call hideMainClubView")
                self.hideMainClubView(webMessage?.val)
                
                
            default :
                print("check function Name")
            }
            
        }
        
        func messageToWebView(msg: String) {
            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
        
        
        // MARK: -WebViewAdapter
        func hideWebView(_ hideWebView: Bool?) {
            let hideWebView = hideWebView ?? true
            self.parent.webViewModel.foo.send(hideWebView)
        }
        
        func hideMainClubView(_ hideMainClubView: Bool?) {
            let hideMainClubView = hideMainClubView ?? true
            self.parent.webViewModel.bar.send(hideMainClubView)
        }
        
        

        
    }
}



//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
