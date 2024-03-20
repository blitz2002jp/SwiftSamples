//
//  OptionalTypeView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/12.
//

import SwiftUI

struct OptionalTypeView: View {
  @Binding var nextView: SwiftTestViews

  var body: some View {
    VStack {
      Text("OptionalType Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      
      Spacer()
      
      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}
