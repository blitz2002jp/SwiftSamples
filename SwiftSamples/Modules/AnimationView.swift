//
//  AnimationView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/10.
//

import SwiftUI

struct AnimationView: View {
  @Binding var nextView: SwiftTestViews
  @State private var effectBounce = false
  @State private var effectScale = false
  @State private var effectPuls = false
  @State private var sliderValSpeed: Double = 0
  @State private var effect: any SymbolEffect = .bounce
  


  @State private var fontSize: Bool = false
  @State private var opacity1: Double = 0
  @State private var opacity2: Double = 0
  @State private var rotationDegrees = 0.0
  @State private var isAnimating1 = false
  @State private var isAnimating2 = false
  @State private var effectBounce2 = false

  private var animation: Animation {
    .linear
    .speed(0.1)
    .repeatForever(autoreverses: false)
  }

  var body: some View {
    VStack {
      
      // withAnimationのサンプル
      Text("withAnimation サンプル")
      
      // withAnimation 表示Delay
      HStack {
        Button {
          withAnimation( Animation.easeIn.delay(3)) {
            if opacity1 == 1 {
              opacity1 = 0
            } else {
              opacity1 = 1
            }
          }
        } label: {
          Text("Delay (3秒後に表示)")
        }
        Text("")
          .padding()
          .background(Color.cyan)
          .cornerRadius(10)
          .opacity(opacity1)
      }
      
      // withAnimation 表示Duration
      HStack {
        Button {
          withAnimation(.default.repeatForever().speed(0.0)) {
            fontSize.toggle()
            print("withAnimation:\(fontSize)")
          }
        } label: {
          Text("test")
        }
        Image(systemName: "speaker.zzz")
          .font(.largeTitle)
          .scaleEffect(fontSize ? 0.7 : 1.0)
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
        Text("withAnimation:\(fontSize)")

      }
      
      HStack {
        Button {
          withAnimation(.default.repeatForever().speed(0.0)) {
            fontSize.toggle()
            print("withAnimation:\(fontSize)")
          }
        } label: {
          Text("test")
        }
        Image(systemName: "speaker.zzz")
          .font(.largeTitle)
          .scaleEffect(fontSize ? 0.7 : 1.0)
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
        Text("withAnimation:\(fontSize)")
      }
      
      HStack {
        Button {
          withAnimation( Animation.linear(duration: 5) ) {
            if opacity2 == 1 {
              opacity2 = 0
            } else {
              opacity2 = 1
            }
          }
        } label: {
          Text("Duration (5秒かけて表示)")
        }
        Text("")
          .padding()
          .background(Color.cyan)
          .cornerRadius(10)
          .opacity(opacity2)
      }
      
      // 回転
      HStack {
        Button("Animating") {
          withAnimation(Animation.linear(duration: 5)){
            if self.isAnimating1 {
              rotationDegrees = 0.0
            } else {
              rotationDegrees = 360.0
            }
            self.isAnimating1.toggle()
          }
        }
        
        Image(systemName: "gear")
          .font(.largeTitle)
          .rotationEffect(.degrees(rotationDegrees))
      }
      HStack {
        Button("PPPP") {
          self.isAnimating2.toggle()
        }
        Button("PPPP") {

          self.effectBounce2.toggle()
        }
        Text("bounce")
        if self.isAnimating2 {
          Image(systemName: "speaker.zzz")
            .symbolEffect(.bounce, options: .speed(sliderValSpeed).repeating , value: effectBounce2)
            .font(.largeTitle)
        } else {
          Image(systemName: "speaker.zzz")
            .symbolEffect(.bounce, options: .speed(sliderValSpeed).repeating , value: effectBounce2)
            .font(.largeTitle)
        }
      }

      Spacer()

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
      Image(systemName: "speaker.zzz")
        .symbolEffect( .bounce , options: .speed(sliderValSpeed).repeating , value: effectBounce)
//        .font(.largeTitle)
        .onTapGesture {
          print(self.effectBounce)
          self.effectBounce.toggle()
          print(self.effectBounce)
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
      /*
      self.effectBounce.toggle()
      self.effectScale.toggle()
      self.effectPuls.toggle()
       */
    }
  }
}
