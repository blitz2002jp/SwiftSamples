//
//  TestEtcView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/28.
//

import SwiftUI

struct TestEtcView: View {
  @Binding var nextView: SwiftTestViews
  @State private var isAnimating = false
  @State private var scale: CGFloat = 1
  
  var body: some View {
    VStack {
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(.blue)
            .scaleEffect(scale) // スケールを変更する
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: scale) // アニメーションを追加

        HStack {
            Button("Start Animation") {
                self.isAnimating = true // アニメーションを開始する
                self.scale = 2 // スケールを変更してアニメーションをトリガーする
            }

            Button("Stop Animation") {
                self.isAnimating = false // アニメーションを停止する
                // アニメーションをリセットする
                withAnimation(.none) {
                    self.scale = 1
                }
            }
        }
    }
  }
}

