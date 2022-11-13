//
//  ScheduleView.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/29.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var actInfoViewModel:ActInfoViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack{
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .frame(width:30, height: 30)
                            
                        }
                        Spacer()
                    }
                    
                    HStack(alignment: .center) {
                        Text("10월 01일 토요일")
                    }
                }
                
                
                HStack {
                    VStack (alignment: .leading, spacing: 10){
                        Text("일정")
                            .bold()
                            .font(.system(size: 30))
                        Text("1일 활동1")
                    }
                    .padding()
                    
                    Spacer()
                }
                .frame(height: 100)
                
                
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
                Spacer()
                
                
            }
            .navigationBarHidden(true)
            .overlay(alignment: .bottom) {
                NavigationLink {
                    Text("duummy")
                } label: {
                    ButtonParticipate
                }
                
            }
            
        }
        
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

struct User: Identifiable {
    
    var id: String { userId }
    let userId: String
    let name: String
    
    init(userId: String, name: String) {
        self.userId = userId
        self.name = name
    }
    
}

class ActInfoViewModel: ObservableObject {
    let actId: String
    
    @Published var users = [User]()
    
    init(actId: String) {
        self.actId = actId
        
        fetchParticipants()
    }
    func fetchParticipants() {
        // requset 구문추가
        
        // Dummy Data
        users.append(User.init(userId: "1", name: "오승철"))
        users.append(User.init(userId: "2", name: "정찬웅"))
        users.append(User.init(userId: "3", name: "정수진"))
        users.append(User.init(userId: "4", name: "최은정"))
    }
    
}

struct RowParticipant: View {
    let user: User
    
    
    var body: some View {
        
        HStack {
            Image(systemName: "person.fill")
            Text(user.name)
        }
    }
    
    
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(actInfoViewModel: ActInfoViewModel.init(actId: "1"))
    }
}
