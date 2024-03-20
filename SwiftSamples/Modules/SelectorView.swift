//
//  SelectorView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/21.
//

import SwiftUI

struct SelectorView: View {
  @Binding var nextView: SwiftTestViews

  var body: some View {
    Text("SelectorView")
      .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    Text("未実装")
      .border(Color.red)
      .font(.footnote)

    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}
