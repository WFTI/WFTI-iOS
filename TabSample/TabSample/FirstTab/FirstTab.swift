//
//  FirstTab.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/28.
//

import SwiftUI

struct ActInfo: Identifiable {
    
    var id: String { activityId }
    let activityId: String
    let date, activityTitle: String
    var day:String = ""
    
    init(activityId: String, date: String,activityTitle: String) {
        self.activityId = activityId
        self.activityTitle = activityTitle
        self.date = date
        
        if let date = date.toDate() {
            self.day = date.getDayOfWeek()
        }
        

    }
}

class MyActInfoViewModel: ObservableObject {
    let userId: String
    let month: String
    
    @Published var actInfo = [ActInfo]()
    
    init(userId: String, month: String) {
        self.userId = userId
        self.month = month
        
        fetchActInfo()
    }
    
    private func fetchActInfo() {
        //request 구문추가할 것.
        
        // dummy Data
        self.actInfo.append(ActInfo.init(activityId: "123", date: "20221001", activityTitle: "1일 활동1"))
        self.actInfo.append(ActInfo.init(activityId: "456", date: "20221018", activityTitle: "18일 활동2"))

    }
}


struct FirstTab: View {
    @State private var date = Date()
    @ObservedObject var actInfoVM: MyActInfoViewModel
    
    @State private var showModal = false // ModalViewState
    
    var body: some View {
        NavigationView {
            VStack{
                
                ZStack {
                    
                    DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        

                }
                
                
                List {
                    

                    ForEach(actInfoVM.actInfo) { actInfo in

//                        NavigationLink {
//                            ScheduleView()
//                        } label: {
//
//
//                        }
                        
                        RowDay(actInfo: ActInfo.init(activityId: actInfo.id, date: actInfo.date, activityTitle: actInfo.activityTitle))
                            .onTapGesture {
                                print("hello")
                                self.showModal = true
                            }
                            .fullScreenCover(isPresented: self.$showModal){
                                ScheduleView(actInfoViewModel: ActInfoViewModel.init(actId: "1"))
                            }
                    }
                    
                }
                .frame( maxWidth: .infinity)
    //            .edgesIgnoringSafeArea(.all)
                .listStyle(PlainListStyle())
    //            .listStyle(GroupedListStyle())


            }
            .navigationTitle("")
            .navigationBarHidden(true)
        } // EndOf NavigationView
//        .navigationBarHidden(true)
//        .navigationTitle("")

        
    }
}

struct RowDay: View {
    
    let actInfo: ActInfo
    
    
    var body: some View {
        HStack (spacing: 15){
            VStack {
                Text(actInfo.date.subString(from: 6, to: 8))
                    .bold()
                    .font(.system(size: 30))
                Text(actInfo.day)
                    .font(.system(size: 15))

            }
            Text(actInfo.activityTitle)
                .font(.system(size: 20))
            Spacer()

        }
//        .frame(maxWidth: .infinity)
//        .background(Color.blue)
    
    }

}

struct FirstTab_Previews: PreviewProvider {
    static var previews: some View {
        FirstTab(actInfoVM: MyActInfoViewModel.init(userId: "123", month: "202210"))
    }
}
