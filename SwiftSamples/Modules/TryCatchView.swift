//
//  TryCatchView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/27.
//

import SwiftUI

enum MyError: Error {
    case error(Int, String)
}
struct TryCatchView: View {
  @Binding var nextView: SwiftTestViews
  @State private var isShowAlert: Bool = false    // アラート表示Switch
  @State private var errorMessage = ""
  
  var body: some View {
    VStack {
      Text("TryCatchView")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Spacer()
      Button("エラーをThrows") {
        let errorThrows = ErrorThrows()
        do {
          try errorThrows.err0()
        } catch {
          self.errorMessage = error.localizedDescription
          self.isShowAlert = true
        }
      }
      Spacer()
      Button("自前のエラーをThrows") {
        let errorThrows = ErrorThrows()
        do {
          try errorThrows.err1()
        } catch {
          self.errorMessage = error.localizedDescription
          self.isShowAlert = true
        }
      }

      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
    .alert("Error", isPresented: $isShowAlert) {
      // ダイアログ内で行うアクション処理...
      
    } message: {
      // アラートのメッセージ...
      Text("エラーが発生しました\n\(self.errorMessage)")
    }

  }
}

class ErrorThrows {
  /// エラーをThrowする
  func err0() throws {
    print("err0 : エラーをThrows")

    let filePath = "/xxxxx/xx/xxxxx/file.txt"
    let fileContent = ""
    try fileContent.write(toFile: filePath, atomically: true, encoding: .utf8)
  }

  /// 自前のエラーをThrowする
  func err1() throws {
    print("err1 : 自前のエラーをThrows")
    throw MyError.error(1001, "An error occurred")
  }
  
  /// エラーが発生しない
  func err2() throws {
    print("err2 : エラーなし")
  }
}

