//
//  ClubViewThirdTab.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/12.
//

import SwiftUI

struct ClubViewThirdTab: View {
    
    @ObservedObject var actInfoViewModel:ActInfoViewModel = ActInfoViewModel(actId: "1")
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 10){
                    Text("참여자")
                        .bold()
                        .font(.system(size: 30))
                    
                    
                    ForEach(actInfoViewModel.users) { user in
                        RowParticipant(user: user)
                    }
                    
                }
                .padding()
                
                Spacer()
                
            }
        }
    }
}

//struct ClubViewThirdTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubViewThirdTab()
//    }
//}
