//
//  SecondTab.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/12.
//

import SwiftUI

final class AppData: ObservableObject {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

struct SecondTab: View {
    @ObservedObject var webViewModel: WebViewModel
    var url: String?
    var isInnerHTML: Bool?
    
    @State var showMainClubView = false
    
    var body: some View {
        
        
        WebView(webViewModel: webViewModel, url: url, isInnerHTML: isInnerHTML)
            .fullScreenCover(isPresented: $showMainClubView) {
                
                
                MainClubView()
                
                
                
            }
            .onReceive(self.webViewModel.bar) { bar in
                print("show MainClubView")
                showMainClubView = !bar
            }
            .transaction { transaction in
                print(transaction.animation)
                transaction.animation = nil
            }
        
        
//                    if showMainClubView {
//                            MainClubView()
//        //                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        //                .frame(width: UIApplication.shared.keyWindow?.frame.width,
//        //                       height: UIApplication.shared.keyWindow?.frame.height)
//        //                .edgesIgnoringSafeArea(.all)
//        //                .padding(.top)
//                    }
        
        
        
    }
}

extension View {
    func withoutAnimation(_ work: @escaping () -> Void) {
        UIView.setAnimationsEnabled(false) //<== Disable animation for whole app
        work()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.setAnimationsEnabled(true) //<== Again enable animation for whole app
        }
    }
}

//struct SecondTab_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondTab()
//    }
//}
