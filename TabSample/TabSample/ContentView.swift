//
//  ContentView.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/28.
//

import SwiftUI

struct ContentView: View {
    
//    @State var showWebView = true
    @State var hideWebView = false
    @ObservedObject var webViewModel = WebViewModel()

    
    var body: some View {
        ZStack {
            // TabView
            TabView {
                //First Tab
                FirstTab(actInfoVM: MyActInfoViewModel.init(userId: "123", month: "202210"))
                    .tabItem {
                        Image(systemName: "house.fill")
                    }

                Text("Sec Tab")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }
                
                
                // Test Tab
                TestTab()
                    .tabItem {
                        Image(systemName: "testtube.2")
                        Text("Test Tab")
                    }


            }
            
            
            // WebView
            if !hideWebView {
                WebView(webViewModel: webViewModel)
                    .onReceive(self.webViewModel.foo) {  foo  in
                        print(foo)
//                        hideWebView.toggle()
                        hideWebView = foo
                    
                    }
            }
            
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
