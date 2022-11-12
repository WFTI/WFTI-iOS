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
                print("hideWebView")
//                self.webView?.isHidden = webMessage?.val ?? true
//                self.webView?.removeFromSuperview()
                let hideWebView = webMessage?.val ?? true
                self.parent.webViewModel.foo.send(hideWebView)
                
                
            default :
                print("check function Name")
            }
            
        }
        
        func messageToWebView(msg: String) {
            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
        

        
    }
    
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
        guard let path: String = Bundle.main.path(forResource: "index", ofType: "html") else { return }
        let localeHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        webView.loadFileURL(localeHTMLUrl, allowingReadAccessTo: localeHTMLUrl)
        
    }
    

}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
