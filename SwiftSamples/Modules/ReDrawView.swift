//
//  ReDrawView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/16.
//

import SwiftUI


struct ReDrawView: View {
  @Binding var nextView: SwiftTestViews
  
  @State var redrawFlg = false
  
  @State var showReDrawSeet1 = false
  @State var showReDrawSeet2 = false

  var body: some View {
    
    Text("Redraw")
      .font(.title)
      .foregroundStyle(self.redrawFlg ? .orange : .blue)
      .onAppear() {
        self.redrawFlg.toggle()
      }
    
    Button("ReDraw1") {
      self.showReDrawSeet1 = true
    }
    .sheet(isPresented: self.$showReDrawSeet1, onDismiss: {} ) {
      reDrawSeet1()
        .presentationDetents([.medium])
    }
    Button("ReDraw2") {
      self.showReDrawSeet1 = true
    }
    .sheet(isPresented: self.$showReDrawSeet2, onDismiss: {} ) {
      reDrawSeet2()
        .presentationDetents([.medium])
    }

    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}

// 単純なRedrawチェック
struct reDrawSeet1: View {
  @State var redrawFlg = false
  let redraw = util()

  var body: some View {
    VStack {
      Button("Redraw") {
        self.redrawFlg.toggle()
      }
      .foregroundStyle(self.redrawFlg ? .blue : .red)

      Button("強制Redraw") {
        self.redraw.redraw()
      }

      Text("現在時刻:\(self.getNow())")
        .font(.title)
    }
  }
  func getNow() -> String {
    let now = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: now)
  }
}

// デリゲートで通知を受けて画面の再描画を行うView
struct reDrawSeet2: View , TestDelegate, PlayerDelegateCurrentTime {
  @State var notifyValue = "pppp"
  @State var timeInt: TimeInterval?

  let timeClass = TimerClass()
  let playerClass = PlayerTestClass()
  init() {
    self.timeClass.delegateTest1 = self
    self.playerClass.delegateCurrentTime = self
  }
  
  var body: some View {
    VStack( spacing: 30) {
      HStack(spacing: 40) {
        Button("Start Timer") {
          self.notifyValue = "TAP"
          print("Button Tap:\(self.notifyValue)")
          self.timeClass.startTimer()
        }
        Button("Stop Timer") {
          self.timeClass.startTimer()
          self.playerClass.Play()
        }
      }
      
      Text("Notify Value : \(self.notifyValue)")
    }
  }
  // デリゲート
  func notify1(val: Int) {
    /*
    DispatchQueue.main.async {
      self.notifyValue = String(val)
      self.notifyValue = "YYYYY"
      print("Notify1:\(self.notifyValue)")
    }
     */
    DispatchQueue.main.async {
      self.notifyValue = String(val)
      print("Notify1:\(self.notifyValue)  Val:\(val)")
    }

  }
  
  func notifyCurrentTime(currentTime: TimeInterval) {
    self.timeInt = currentTime
    print("")
  }
}

protocol TestDelegate {
  // 再生終了の通知
  func notify1( val: Int)
}

class TimerClass {
  // 通知用デリゲート
  var delegateTest1: TestDelegate?
  
  var val: Int = 0
  
  /// 再生時間表示タイマー
  private var timer: Timer?
  
  func startTimer() {
    // 時間通知
    if let dg = self.delegateTest1 {
      self.val += 1
      dg.notify1(val: self.val)
    }

    /*
    self.stopTimer()
    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerEvent2), userInfo: nil, repeats: true)
     */
  }
  
  func stopTimer() {
    if self.timer != nil {
      self.timer?.invalidate()
    }
  }
  
  // タイマーイベント
  @objc func timerEvent2(){
    // 時間通知
    if let dg = self.delegateTest1 {
      self.val += 1
      dg.notify1(val: self.val)
    }
  }
}



//
//
//
//
//
//  Player.swift
//  SoundPlayer
//
//  Created by masazumi oeda on 2024/02/22.
//

protocol PlayerDelegateCurrentTime {
  // 再生時間の通知
  func notifyCurrentTime(currentTime: TimeInterval)
}

class PlayerTestClass: NSObject {
  

  /// 再生時間表示タイマー
  private var timer: Timer?
  
  // 通知用デリゲート
  var delegateCurrentTime: PlayerDelegateCurrentTime?

  // Play
  func Play() {
      // 再生時間表示タイマー
      if self.timer != nil {
        self.timer?.invalidate()
      }
      self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
    }
  
  // Pause
  func pauseSound(){
    // 再生時間表示タイマー
    if self.timer != nil {
      self.timer?.invalidate()
    }
  }

// タイマーイベント
  @objc func timerEvent(){
    // 時間通知
    if let dg = self.delegateCurrentTime {
      dg.notifyCurrentTime(currentTime: TimeInterval.zero)
    }
  }
}


class util: ObservableObject {
  // 再描画
  func redraw(){
    print("redraw")
    objectWillChange.send()
  }
}
