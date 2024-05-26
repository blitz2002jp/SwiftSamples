//
//  TestEtcView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/28.
//

import SwiftUI

struct TestEtcView: View {
  @Binding var nextView: SwiftTestViews
  @State var url1: URL?
  @State var url2: URL?

  var body: some View {
    Button("TEST") {
      self.url1 = self.getDocumentDirectory(add: "")
      self.url2 = self.getDocumentDirectory(add: "aaa")
      
      print(url1?.absoluteString)
      print(url2?.absoluteString)
      if self.url1 == self.url2 {
        print("EQ")
      } else {
        print("NE")
      }
    }
  }
  
  /// Documentディレクトリ取得
  func getDocumentDirectory(add: String) -> URL?{
    if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      return docDir.appendingPathComponent(add)
    }
    return nil
  }
}


