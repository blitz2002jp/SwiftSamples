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
  @State private var isPlaying = false
  @State private var speedval = 2.5
  @State private var effectFlg = false
  
  var body: some View {
    VStack {
      ForEach(images.animationImages, id: \.id) { item in
        if item.isSelected {
          HStack {
            if self.isPlaying {
              Image(systemName:  "speaker.zzz")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
                .scaleEffect(self.effectFlg ? 1 : 0.8)
            } else {
              Image(systemName: "speaker")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
            }
          }
        } else {
          HStack {
            Image(systemName: "dog")
              .font(.system(size: 30))
              .foregroundStyle(.green)
              .onTapGesture {
                // 全選択解除して選択
                images.animationImages.forEach { item in item.isSelected = false}
                item.isSelected = true
                self.isPlaying = false
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
          self.isPlaying = false
        } else {
          // 選択されているものが無い場合、先頭を選択
          if self.images.animationImages.first(where: {$0.isSelected}) == nil {
            self.images.animationImages[0].isSelected = true
          }
          
          self.isPlaying = true
          self.speedval = 2.5
          withAnimation(.default.repeatForever().speed(self.speedval)) {
            self.effectFlg.toggle()
          }
        }
      }, label: {Image(systemName: self.isPlaying ? "pause.fill" : "play")})
    }
    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
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
