//
//  SwiftUniqueView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/07.
//

import SwiftUI

struct SwiftUniqueView: View {
  @Binding var nextView: SwiftTestViews
  
  var body: some View {
    VStack {
      Text("TestEtcView")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Text("Swift特有の現象などを再現")
        .foregroundStyle(.orange)
      Spacer()
      
      Button("Privateプロパティ(ソースコード参照)") {
        _ = SwiftUniqueAccessLevel()
      }
      
      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}

///
/// アクセスレベルがPrivateなプロパティがある場合の構造体の注意点
///
///  エラー）
///　　prop2が初期化なし「var prop2: String」で定義されている場合、「'SwiftUniqueAccessLevel' initializer is inaccessible due to 'private' protection level」エラーが発生する
///
///　原因）
///　　初期化されていないプロパティがある場合、Swiftは「Memberwise Initializer」が勝手にプロパティ初期化を行おうとする
///　　そのためprivateプロパティ「prop1」にアクセスできないためエラーが発生する。
///
///　対処）
///　　 1 コンストラクタ（init）を作成して初期化を行う
///　　 2 プロパティ定義時に初期化を行う
///
///　　 どちらかの対処で解決する
///
struct SwiftUniqueAccessLevel {
  // この例ではPrivateなプロパティ「prop1」と初期化していないプロパティ「prop2」を定義することで、問題を再現できる
  
  // Privateなプロパティが存在する
  private var prop1: String = ""
  
  //　初期化していないプロパティが存在する
  //  var prop2: String
  var prop2: String = ""        //　対処 １　定義時に初期化

  //　対処 ２
  // コンストラクタを定義して初期化していないプロパティを無くす
/*
  init(){
    // 初期化していないプロパティを初期化する
    self.prop2 = ""
  }
*/
}
