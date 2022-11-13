//
//  ClubViewFirstTab.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/12.
//

import SwiftUI

struct ClubViewFirstTab: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    
                   
            }
            
            HStack(alignment: .top) {
                Text("""
                     🔥우리FIS 18기 2022 CoP🔥 \
                     
                       
                       2주마다 작업 분량 점검 & 공유 \
                       AI, BackEnd, FrontEnd, Mobile 등 다양한 분야 경험가능 \
                       
                     
                       동기끼리 편하게!
                     """
                )
                Spacer()
            }
            
            HStack {
                Spacer()
            }
            Spacer()
        }
        .overlay(alignment: .bottom) {
            ButtonParticipate

        }
//        .frame(
//              minWidth: 0,
//              maxWidth: .infinity,
//              minHeight: 0,
//              maxHeight: .infinity,
//              alignment: .topLeading
//            )
//

        
    }
    
    var ButtonParticipate:some View {
        
        HStack {
            Spacer()
            Text("참여하기")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical)
        .background(Color.blue)
        .cornerRadius(32)
        .padding(.horizontal)
        
    }
}

struct ClubViewFirstTab_Previews: PreviewProvider {
    static var previews: some View {
        ClubViewFirstTab()
    }
}
