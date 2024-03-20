//
//  DelegateView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/21.
//

import SwiftUI

struct DelegateView: View {
  @Binding var nextView: SwiftTestViews
  
  var body: some View {
    Text("DelegateView")
      .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    Text("Delegateのサンプル")
      .border(Color.red)
      .font(.footnote)
    Spacer()

    Button("Delegate") {
      let cls001 = cls100()
      cls001.f0()
    }
    
    // 戻るボタン
    Spacer()
    Button("Return"){
      //nextView = .topView
    }
  }
}

/// プロトコル定義
protocol PlayerDelegate {
  func notifyPlayTime(time: TimeInterval)
}

/// 処理を任せる(デリゲートする)クラス
class Test1{
  var delegate: PlayerDelegate? = nil
  func play(){
    if let dg = self.delegate {
      // 12:34:56 <- デリゲートを実装したメソッドに返す値
      let time = TimeInterval( (12 * 3600) + (34 * 60) + 56)
      dg.notifyPlayTime(time: time)
    }
  }
}

/// デリゲートされた処理を実装するクラス
class cls100: PlayerDelegate {
  let test1 = Test1()
  init(){
    test1.delegate = self
  }
  
  func f0(){
    test1.play()
  }
  
  // 
  func notifyPlayTime(time: TimeInterval) {
    
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    
    print(formatter.string(from: time) ?? "NIL") // Output: 12:34:56
  }
}
