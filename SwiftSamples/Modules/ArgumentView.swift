//
//  PropertyWarpView.swift
//  SwiftTest
//
//  Created by masazumi oeda on 2024/02/13.
//

import SwiftUI

struct ArgumentView: View {
  @Binding var nextView: SwiftTestViews
  @State var val0: String = "初期値"

  @State private var count: Int = 0


  var body: some View {
    Button("① Swiftの値渡し、参照渡し"){
      let val1: String = "初期値"
      var val2: String = "初期値"
      let val3: cls1 = cls1()   // クラス
      let val4: str1 = str1()   // 構造体
      var val5: str1 = str1()   // 構造体

      print("Before val2=\(val2)")
      print("Before val3=\(val3.v1)")
      print("Before val5=\(val5.v1)")

      /// val1は値渡し
      /// val2は参照渡し(&を付けて渡す）
      /// val3はクラスのインスタンスなので参照渡し
      /// val4は構造体のインスタンスなので値渡し
      updateArg(arg1: val1, arg2: &val2, arg3: val3, arg4: val4, arg5: &val5)
      
      print("After val2=\(val2)")
      print("After val3=\(val3.v1)")
      print("After val5=\(val5.v1)")
    }
    .padding(.top, 10)

    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }


  /// ① Swiftの値渡し、参照渡し
  ///
  ///  arg1は値渡しのため、更新不可
  ///  arg2は参照渡しのため、更新可能
  ///  arg3はClassなのでデフォルトで参照渡しになるので、更新可能
  ///  arg4はStructなのでデフォルトで値渡しになるので、更新不可
  ///  arg5はStructだが参照値渡ししたので、更新可能

  func updateArg(arg1: String, arg2: inout String, arg3: cls1, arg4: str1, arg5: inout str1){
  // arg1 = "メソッド内で変更"     // 値渡しの引数は更新不可エラー「Cannot assign to value: 'arg1' is a 'let' constant」

    arg2 = "メソッド内で変更"

    arg3.v1 = "メソッド内で変更"

  //  arg4.v1 = "メソッド内で変更"  // 値渡しの引数は更新不可エラー「Cannot assign to property: 'arg4' is a 'let' constant」

    arg5.v1 = "メソッド内で変更"
  }
}

// ① クラスが参照渡しである確認用クラス
class cls1{
  var v1: String = "初期値"
  
  func f1(){
    print("v1=\(self.v1)")
  }
}

// ① 構造体が値渡しである確認用構造体
struct str1{
  var v1: String = "初期値"
  
  func f1(){
    print("v1=\(self.v1)")
  }
}
