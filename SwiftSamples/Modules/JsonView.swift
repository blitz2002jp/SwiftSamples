//
//  JsonView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/03/22.
//

import SwiftUI

struct JsonView: View {
  @Binding var nextView: SwiftTestViews
  
  var body: some View {
    VStack {
      Text("Json Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Text("JsonのEncode、Decodeのテスト")
        .font(.none)
      Spacer()
      Button("単純なEncode Decode") {
        // エンコード( Swiftオブジェクト(クラス) -> Json )
        do {
          let encoder = JSONEncoder()   // Jsonエンコーダー
          let targetData = JsonTestClass1(no: 1, name: "name 1", classType: "1sonTestClass1")
          let jsonData = try encoder.encode(targetData)
          print("Encodeデータ：\(jsonData)")
          
          // デコード( Json -> Swiftオブジェクト(クラス) )
          let decoder = JSONDecoder()   // Jsonデコーダー
          let decodeData = try decoder.decode(JsonTestClass1.self, from: jsonData)
          print("Decodeデータ： no(\(decodeData.no)) name(\(decodeData.name))")
        } catch {
          print("Jsonエンコードエラー\(error.localizedDescription)")
        }
      }
      Button("単純なEncode Decode") {
        // エンコード( Swiftオブジェクト(クラス) -> Json )
        do {
          let encoder = JSONEncoder()   // Jsonエンコーダー
          let targetData = JsonTestClassChild1(no: 2, name: "name 2", classType: "child 1")
          let jsonData = try encoder.encode(targetData)
          print("Encodeデータ：\(jsonData)")
          
          // デコード( Json -> Swiftオブジェクト(クラス) )
          let decoder = JSONDecoder()   // Jsonデコーダー
          let decodeData = try decoder.decode(JsonTestClassParent1.self, from: jsonData)
          print("Decodeデータ： no(\(decodeData.no)) classType(\(decodeData.name)) name(\(decodeData.classType))")
        } catch {
          print("Jsonエンコードエラー\(error.localizedDescription)")
        }
      }
    }
  }
}

/// 「単純なEncode Decode」テスト用クラス
///
///
///
///
///
class JsonTestClass1: Codable {
  var no: Int
  var name: String
  var classType: String

  init(no: Int, name: String, classType: String) {
    self.no = no
    self.name = name
    self.classType = classType
  }
}


/// 「required initが必要なケース」との比較のため「required initが必要なケース」不要なケース
///
///　JsonTestClassParent2（「required initが必要なケース」）との違い：
///　　子クラス(JsonTestClassChild1)でinitをoverrideしていない
///
///
class JsonTestClassParent1: Codable {
  var no: Int
  var name: String
  var classType: String

  init(no: Int, name: String, classType: String) {
    self.no = no
    self.name = name
    self.classType = classType
  }
}

// 子クラス２
class JsonTestClassChild1: JsonTestClassParent1 {
}


/// required initが必要なケース
///
///　子クラス(JsonTestClassChild2)でinitをoverrideすると「required init」が必要になる
///
///
///
// 親クラス２
class JsonTestClassParent2: Codable {
  var no: Int
  var name: String
  var classType: String
  
  init(no: Int, name: String, classType: String) {
    self.no = no
    self.name = name
    self.classType = classType
  }

  // デコード用init
  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.no = try container.decode(Int.self, forKey: .no)
    self.name = try container.decode(String.self, forKey: .name)
    self.classType = try container.decode(String.self, forKey: .classType)
  }
  
  // デコード用initで使用するenum(プロパティ分定義）
  enum CodingKeys: String, CodingKey {
      case no
      case name
      case classType
  }

}

// 子クラス２
class JsonTestClassChild2: JsonTestClassParent2 {
  
  // initをOrerRide
  override init(no: Int, name: String, classType: String) {
    super.init(no: no, name: name, classType: classType)
  }

  // このクラスへのデコードを行うと、呼ばれる
  required init(from decoder: any Decoder) throws {
    // 親クラスのデコード用initをコール
    try super.init(from: decoder)
  }
}


