//
//  TestEtcView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/28.
//

import SwiftUI

struct TestEtcView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DetailView()) {
                    Text("Go to Detail View")
                }
            }
            .navigationTitle("Main View")
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear(){
          var a1:String? = "1111"
          var a2:String?
          let aaaa = a()
          aaaa.f1(arg1: a1)
          aaaa.f1(arg1: a2)
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .navigationTitle("Detail")
    }
}


class a{
  func f1(arg1: String?){
    print("aaaa:\(String(describing: arg1))")
  }
}
