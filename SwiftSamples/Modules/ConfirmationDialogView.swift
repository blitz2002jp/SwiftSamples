//
//  ConfirmationDialogView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/03/25.
//

import SwiftUI

struct ConfirmationDialogView: View {
  @Binding var nextView: SwiftTestViews
  @State var showingDialog = false

  var body: some View {
    VStack {
      Text("ConfirmationDialog Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
     
      Button("vvvv") {
        self.showingDialog = true
      }
      .confirmationDialog("タイトル", isPresented: $showingDialog, titleVisibility: .visible) {
          Button("選択肢1") {
              // 選択肢1ボタンが押された時の処理
          }
          Button("選択肢2") {
              // 選択肢2ボタンが押された時の処理
          }
      } message: {
          Text("詳細メッセージ").bold()
      }
      
      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}
