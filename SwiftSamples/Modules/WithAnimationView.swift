//
//  WithAnimationView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/16.
//

import SwiftUI

struct WithAnimationView: View {
  @Binding var nextView: SwiftTestViews
  
  @StateObject private var images: AnimationImageWrapper = AnimationImageWrapper()
  @State private var isPlaying = false  // 再生中
  @State private var speedval = 2.5     // Animation速度
  @State private var effectFlg = false  // scaleEffect用
  
  var body: some View {
    VStack {
      ForEach(images.animationImages, id: \.id) { item in
        if item.isSelected {
          HStack {
            if self.isPlaying {
              // 再生中イメージ表示
              Image(systemName:  "speaker.zzz")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
                // スケールエフェクト(effectFlgをwithAnimationでTogleされアニメーション表示される）
                .scaleEffect(self.effectFlg ? 1 : 0.8)
                .onTapGesture {
                  // アニメーション停止
                  self.stopAnimation()
                }
            } else {
              // 停止中イメージ表示
              Image(systemName: "speaker")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
                .onTapGesture {
                  // アニメーション開始
                  self.startAnimation()
                }
            }
          }
        } else {
          HStack {
            // 未選択イメージ表示
            Image(systemName: "dog")
              .font(.system(size: 30))
              .foregroundStyle(.green)
              .onTapGesture {
                // アニメーション停止
                self.stopAnimation()
                
                // 全選択解除して選択
                images.animationImages.forEach { item in item.isSelected = false}
                item.isSelected = true

                // アニメーション開始
                self.startAnimation()

                // AnimationImageWrapperが自動的に再描画されない（クラスがネストしているから？）ので強制再描画
                self.images.objectWillChange.send()
              }
          }
        }
      }
    }
    Spacer()
    
    HStack {
      Button(action: {
        if self.isPlaying {
          // アニメーション停止
          self.stopAnimation()
        } else {
          // 選択されているものが無い場合、先頭を選択
          if self.images.animationImages.first(where: {$0.isSelected}) == nil {
            self.images.animationImages[0].isSelected = true
          }

          // アニメーション開始
          self.startAnimation()
        }
      }, label: {Image(systemName: self.isPlaying ? "pause.fill" : "play")})
    }
    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
  
  // アニメーション開始
  func startAnimation() {
    self.isPlaying = true
    self.speedval = 2.5
    withAnimation(.default.repeatForever().speed(self.speedval)) {
      self.effectFlg.toggle()
    }
  }
  
  // アニメーション停止
  func stopAnimation() {
    self.isPlaying = false
  }
}

class AnimationImageWrapper: ObservableObject {
  @Published var animationImages = [AnimationImage]()
  
  init() {
    animationImages = [AnimationImage(no: 1),AnimationImage(no: 2),AnimationImage(no: 3),AnimationImage(no: 4)]
  }
}

class AnimationImage: ObservableObject, Identifiable{
  var no = 0
  @Published var isSelected = false
  
  init(no: Int, isSelected: Bool = false) {
    self.no = no
    self.isSelected = isSelected
  }
}
