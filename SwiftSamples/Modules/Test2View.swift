//
//  Test2View.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/07.
//

import SwiftUI

struct Test2View: View {
  @Binding var nextView: SwiftTestViews
  @State var isCreateWeakData = true
  @State var childWeak: Child_Test?
  @State var parentWeak: ParentWeak_Test?

  var body: some View {
    VStack {
      Button("Create Weak Data") {
        // Weakテスト用インスタンス作成
        self.childWeak = Child_Test(name: "Weak Child")
        self.parentWeak = ParentWeak_Test(name: "Weak Parent")
        self.parentWeak?.child = childWeak

        self.isCreateWeakData = false
        
      }
      .disabled(self.isCreateWeakData == false)
      
      Button("Free Weak") {
        // Childインスタンス削除
        //self.childWeak = nil
        self.parentWeak = nil

        // ParentWeakクラスでWeak(弱参照)なのでChildインスタンスのdeinitが実行される

        self.isCreateWeakData = true
      }
      .disabled(self.isCreateWeakData == true)

      Spacer()

      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}

class Child_Test {
    let name: String
    
    init(name: String) {
        self.name = name
        print("Child Name : \(name) Child initialized")
    }
    
    deinit {
        print("Child Name : \(name) Child deinitialized")
    }
}

class ParentWeak_Test {
  let name: String
  weak var child: Child_Test? // weak参照
  
  init(name: String) {
    self.name = name
    print("Parent Name : \(name) Weak Parent initialized")
  }
  
  deinit {
    print("Parent Name : \(name) Weak Parent deinitialized")
  }
}

