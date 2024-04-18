//
//  SwiftBlock.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/17.
//

import SwiftUI

struct SwiftBlock: View {
  @Binding var nextView: SwiftTestViews

  var body: some View {
    Text("Swiftのプロック")
      .font(.title)
    

    Button("ブロックの動作１") {
      // ブロックの指定方法１
      self.performOperationWithBlock({
          print("ブロックの指定法１")
          // ここに任意の処理を記述する
      })
      
      // ブロックの指定方法２
      self.performOperationWithBlock() {
        print("ブロックの指定法２")
      }
    }
    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }

  }

  // ブロックを指定できるメソッド
  func performOperationWithBlock(_ operation: () -> Void) {
      print("Operation starts")
      operation() // 渡されたクロージャを実行
      print("Operation ends")
  }
}
