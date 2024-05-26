//
//  TempView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/23.
//

import SwiftUI

struct Test2View: View {
  @Binding var nextView: SwiftTestViews
  @State var isActive = false
  
  let list = ["A", "B", "C", "D", "E"]
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(self.list, id: \.self) { item in
          Text(item)
            .onTapGesture {
              self.isActive.toggle()
            }
        }
      }
      .background(
        NavigationLink(destination: nextTest2View(), isActive: $isActive) {
          EmptyView()
        })
    }
  }
}

struct nextTest2View: View {
  let list = ["1", "2", "3", "4", "5"]
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(self.list, id: \.self) { item in
          Text(item)
        }
      }
    }
  }
}
