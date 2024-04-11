//
//  AnimationSfSymbol.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/10.
//

import SwiftUI

struct AnimationSfSymbol: View {
  @Binding var nextView: SwiftTestViews
  @State private var effectBounce = false
  @State private var effectScale = false
  @State private var effectPuls = false
  @State private var sliderValSpeed: Double = 0
  @State private var effect: any SymbolEffect = .bounce
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text("\(self.sliderValSpeed)")
      }
      HStack {
        Text("Speed")
        Slider(
          value: $sliderValSpeed,
          in: 0...10,
          step: 0.1
        ) {
          Text("sliderVal")
        } onEditingChanged: { item in }
          .onChange(of: sliderValSpeed) {
            self.effectBounce.toggle()
            self.effectScale.toggle()
            self.effectPuls.toggle()
          }
          .padding(.bottom, 30)
      }
      
      // バウンス Effect
      Text("bounce")
      Image(systemName: "cat.fill")
        .symbolEffect( .bounce , options: .speed(sliderValSpeed).repeating , value: effectBounce)
        .font(.largeTitle)
        .onTapGesture {
          self.effectBounce.toggle()
        }
      Spacer()
      
      // スケール Effect
      Text("scale")
      Image(systemName: "cat")
        .symbolEffect( .scale.up , isActive: effectScale)
        .font(.largeTitle)
        .onTapGesture {
          self.effectScale.toggle()
        }
      Spacer()
      
      // パルス Effect
      Text("pulse")
      Image(systemName: "dog.fill")
        .symbolEffect( .pulse , options: .speed(sliderValSpeed).repeating , value: effectPuls)
        .font(.largeTitle)
        .onTapGesture {
          self.effectPuls.toggle()
        }
      Spacer()

      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
    .onAppear() {
      self.effectBounce.toggle()
      self.effectScale.toggle()
      self.effectPuls.toggle()
    }
  }
}
