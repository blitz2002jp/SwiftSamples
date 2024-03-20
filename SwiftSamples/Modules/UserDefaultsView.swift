//
//  UserDefaultsView.swift
//  SwiftTest
//
//  Created by masazumi oeda on 2024/02/16.
//

import SwiftUI

struct UserDefaultsView: View {
  @Binding var nextView: SwiftTestViews
  @State private var loadData = ""
  @State private var keysText = ""


  var body: some View {
    Text("PropertyWarpView")
      .font(.title)
    Text("アプリ毎に利用できるキーバリュー型のDB\nアプリの起動時にキーと値のペアを永続的に保存")
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

    Button("①　保存"){
      let dt = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
      _ = dateFormatter.string(from: dt)
      
      // Save
      UserDefaults.standard.set(dateFormatter.string(from: dt), forKey: "CurrentDate")
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    Text("「キー：CurrentDate データ：現在日」を保存")
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(Color.orange)
    
    Button("②　取得"){
      // Load(取得するデータ型で取得メソッドを変更する）
      if let loadedText = UserDefaults.standard.string(forKey: "CurrentDate") {
        loadData = loadedText
      }else{
        loadData = "データなし"
      }
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    Text("「キー：CurrentDate を取得")
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(Color.orange)
    Text(loadData)

    Button("③　削除"){
      // 削除
      UserDefaults.standard.removeObject(forKey: "CurrentDate")
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    Text("「キー：CurrentDateのデータを取得")
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(Color.orange)

    Button("④　キー取得") {
      let keys = UserDefaults.standard.dictionaryRepresentation().keys
      keysText = keys.joined(separator: "\n")
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    ScrollView{
      Text(keysText)
    }
    .frame(maxHeight: 100)
    Text("取得するキーには「AppleLocale」などシステムが管理するものも含まれる")
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(Color.orange)

    /*
     */
    
    
    
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}

// UserDefaultsデータキー取得、全削除
extension UserDefaults {
  
  func getKeyAll() -> [String]{
    var res = [String]()
    dictionaryRepresentation().forEach { res.append($0.key) }
    return res
  }
  
  func removeAll() {
    let keys = getKeyAll()
    keys.forEach{ item in
      removeObject(forKey: item)
    }
  }
}
