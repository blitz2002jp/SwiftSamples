//
//  NvigationView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/13.
//

import SwiftUI

struct NavigationViewTest: View {
  @Binding var nextView: SwiftTestViews
  @State var isLinkActive = false

  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: NavigationTest1View(), isActive: $isLinkActive) {
          Text("Navigation View Test1")
        }
        NavigationLink(destination: NavigationTest2View(), isActive: $isLinkActive) {
          Text("Navigation View Test2")
        }
      }
      .navigationBarTitle("Title", displayMode: .inline)
      .navigationBarItems(leading: Button("戻る"){nextView = .topView})
    }
    if !isLinkActive {
      HStack {
        Button("フッタ") {
          
        }
      }
    }
  }
}

struct NavigationTest1View: View {
  var body: some View {
    Text("1")
    Spacer()
    Button("Return") {
      
    }
  }
}

struct NavigationTest2View: View {
  var body: some View {
    Text("2")
    Spacer()
    Button("Return") {
      
    }
  }
}
