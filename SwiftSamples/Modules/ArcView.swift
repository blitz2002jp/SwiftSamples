//
//  ArcView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/10.
//

import SwiftUI

struct ArcView: View {
  @Binding var nextView: SwiftTestViews

  @State var childWeak: Child?
  @State var parentWeak: ParentWeak?

  @State var childStrong: Child?
  @State var parentStrong: ParentStrong?
  
  var body: some View {
    VStack {
      Text("ARC Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

      Spacer()
      
      Button("Create Weak Data") {
        // Weakテスト用インスタンス作成
        self.childWeak = Child(name: "Weak Child")
        self.parentWeak = ParentWeak(name: "Weak Parent")
        self.parentWeak?.child = childWeak
      }
      
      Button("Free Weak") {
        // Childインスタンス削除
        self.childWeak = nil

        // ParentWeakクラスでWeak(弱参照)なのでChildインスタンスのdeinitが実行される
      }

      Spacer()
      
      Button("Create Strong Data") {
        // Strongテスト用インスタンス作成
        self.childStrong = Child(name: "Strong Child")
        self.parentStrong = ParentStrong(name: "Strong Parent")
        self.parentStrong?.child = childStrong
      }

      Button("Free Strong") {
        // ParentStrongオブジェクトへの強参照を削除
        self.childStrong = nil

        // ParentStrongクラスでStrong(強参照)なのでChildインスタンスのdeinitは実行されない
      }

      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}

class Child: ObservableObject {
  let name: String
//  @Published var child_deinit = false
  
  init(name: String) {
    self.name = name
    print("Child Name : \(name) Child initialized")
  }
  
  deinit {
    print("Child Name : \(name) Child deinitialized")
    
//    self.child_deinit = true
  }
}

class ParentWeak {
  let name: String
//  @Published var parentWeak_deinit = false
  weak var child: Child? // weak参照
  
  init(name: String) {
    self.name = name
    print("Parent Name : \(name) Weak Parent initialized")
  }
  
  deinit {
    print("Parent Name : \(name) Weak Parent deinitialized")
    
//    self.parentWeak_deinit = true
  }
}

class ParentStrong {
  let name: String
  var child: Child? // strong参照
//  @Published var parentStrong_deinit = false

  init(name: String) {
    self.name = name
    print("Parent Name : \(name) Strong Parent initialized")
  }
  
  deinit {
    print("Parent Name : \(name) Strong Parent deinitialized")
    
//    self.parentStrong_deinit = true
  }
}
