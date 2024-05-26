//
//  ApplictionStatus.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/21.
//

import SwiftUI
struct ApplictionStatus: View {
  @Binding var nextView: SwiftTestViews
  
  @State var showNotificationCenterSheet = false
  
  var body: some View {
    
    VStack {
      Button("NotificationCenter(アプリの状態通知)") {
        self.showNotificationCenterSheet = true
      }
      .sheet(isPresented: self.$showNotificationCenterSheet) {
        NotificationCenterView()
      }
    }
  }
}


struct NotificationCenterView: View {
  var body: some View {
    ZStack {
      Text("NotificationCenterによるアプリの状態通知")
      Text("アプリをバックグラウンドへ移行するとprint出力されつ")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { notification in
      print("アクティブになった。")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { notification in
      print("非活性になるよ。")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { notification in
      print("バックグランドになった。")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { notification in
      print("フォアグラウンドになるよ。")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { notification in
      print("アプリ終了するよ。")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
      print("画面が回転したよ")
    }
  }
}
