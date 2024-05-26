//
//  Test2View.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/07.
//

import SwiftUI

struct Test2ViewXX: View {
  @Binding var nextView: SwiftTestViews
  
  var body: some View {
    //    List {
    VStack {
      Text("AAAAAA")
      Text("AAAAAA")
      Text("AAAAAA")
    }
  }
}
//}


struct testV: View {
  @Environment(\.dismiss) var dismiss
  var item: t1?
  var arg2: String = "VOID"
  
  @StateObject var userData = UserData()
  @State private var isShowingProfile = false

  
  var body: some View {
    Button("Close") {
      dismiss()
    }
    Spacer()
    if let _item = item {
      Text("----- \(_item.name) -----")
    } else {
      Text("----- NIL -----")
    }
    Spacer()
    Text("ARG2----- \(self.arg2) -----")

    Spacer()
    Button(action: {
        isShowingProfile = true
    }) {
        Text("Show Profile")
    }
    .sheet(isPresented: $isShowingProfile) {
        ProfileView(userData: userData)
    }

  }
}
                       
class t1: ObservableObject, Identifiable{
  var name = ""
  
  init(name: String = "") {
    self.name = name
  }
}



class UserData: ObservableObject {
    @Published var username = "User"
}

struct ProfileView: View {
    @ObservedObject var userData: UserData
    
    var body: some View {
        Text("Hello, \(userData.username)!")
    }
}


