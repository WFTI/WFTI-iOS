//
//  TestTab.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/29.
//

import SwiftUI

struct TestTab: View {
    
    //    @State private var chats = [Chat]()
    //    @ObservedObject private var chats = [Chat]()
    @ObservedObject private var chatList = ChatList()
    
    var body: some View {
        VStack {
            Text("hello")
            ForEach(chatList.chats) { chat in
                Text(chat.chatId)
            }
            
        }
        
        .onAppear{ // onAppear
            
            let testClass = TestClass()
            //                testClass.loginUser()
            //                chats = testClass.getAllChats()
            
            chatList.setChats(testClass.getAllChats())
            
            
        }
        
        
        
        
    }
    
}

class ChatList: ObservableObject {
    @Published var chats: [Chat] = [Chat]()
    init() {
        
    }
    
    func setChats(_ chatList:[Chat]) {
        self.chats = chatList
        print(chatList)
    }
    
    
}

class Chat: Identifiable,ObservableObject {
    
    var id:String { chatId }
    
    var chatId: String
    let activityId: String
    let activityTitle: String
    
    init(_ chatId:String, _ activityId: String, _ activityTitle: String) {
        self.chatId = chatId
        self.activityId = activityId
        self.activityTitle = activityTitle
    }
    
}

class TestClass:ObservableObject {
    var count = 0
    var chats = [Chat]()
    
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: "flower10@gmail.com", password: "test123") { result, err in
            if let err = err {
                print("Failed to loing user:" , err)
                
                return
            }
            
            print("Sucessfully logged in user: \(result?.user.uid ?? "")")
            self.getAllChats()
        }
        
    }
    
    func getAllChats() -> [Chat] {
        
        
        let document = FirebaseManager.shared.firestore.collection("CLUB")
        var chats = [Chat]()
        
        document.getDocuments { snapshot, error in
            if let error = error {
                print(error)
            }
            //            print(snapshot?.count)
            //            print(snapshot?.documents)
            snapshot?.documents.forEach({ snapshot in
                print(snapshot.data())
                print(snapshot.documentID)
                let chatId = snapshot.documentID
                let activityId = "123"
                let activityTitle = "title"
                
                chats.append(Chat.init(chatId, activityId, activityTitle))
            })
            
            
            
        }
        return chats
    }
    
    
    
    
    
    
}



struct TestTab_Previews: PreviewProvider {
    static var previews: some View {
        TestTab()
    }
}
