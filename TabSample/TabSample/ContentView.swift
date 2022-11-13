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
    @State var hideMainClubView = true

    
    var body: some View {
        ZStack {
            // TabView
            TabView {
                //First Tab
                FirstTab(actInfoVM: MyActInfoViewModel.init(userId: "123", month: "202210"))
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                
                //Second Tab
                SecondTab(webViewModel: webViewModel, url: "search", isInnerHTML: true)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }
                
                
                // Test Tab
//                TestTab()
//                    .tabItem {
//                        Image(systemName: "testtube.2")
//                        Text("Test Tab")
//                    }


            }
            
            
            // WebView
            if !hideWebView {
                WebView(webViewModel: webViewModel, url: "index", isInnerHTML: true)
                    .onReceive(self.webViewModel.foo) {  foo  in
                        print(foo)
//                        hideWebView.toggle()
                        hideWebView = foo
                    
                    }
            }
            
            // MainClubView
            if !hideMainClubView {
                MainClubView()
                    .onReceive(self.webViewModel.bar) { bar in
                        print(bar)
                        hideMainClubView = bar
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
