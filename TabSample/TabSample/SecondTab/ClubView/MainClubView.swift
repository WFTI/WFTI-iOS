//
//  ClubView.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/12.
//

import SwiftUI

struct MainClubView: View {
    @State private var selectedTab: Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "lessthan")
                        .foregroundColor(.black)
                        .frame(width:30, height: 30)
                    
                }
                
                Text("W.F.T.I")
                
                Spacer()
            }
                

            Picker("",selection: $selectedTab) {
                Image(systemName: "info.circle.fill").tag(0)
                Image(systemName: "bubble.left.and.bubble.right.fill").tag(1)
                Image(systemName: "person.2.fill").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.white)
            
            
            switch(selectedTab) {
            case 0: ClubViewFirstTab()
            case 1: ClubViewSecondTab()
            case 2: ClubViewThirdTab()
            default:
                Text("Default")
            }
            Spacer()
        }

        
    }
        
    
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        MainClubView()
    }
}
