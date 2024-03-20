//
//  SliderView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/29.
//

import SwiftUI

struct SliderView: View {
  @Binding var nextView: SwiftTestViews
  @State private var sliderVal: Float = 0
  @State private var isEditing = false
  @State private var logText = ""
  @State private var commonText = "Hello, SwiftUI!"
  @State private var logArr = [String]()
  @State private var maxLineCnt = 10

  var body: some View {
    VStack {
      Text("Slider Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Spacer()
      
      Slider(
        value: $sliderVal,
        in: 0...100,
        step: 5
      ) {
        Text("sliderVal")
      } minimumValueLabel: {
        Text("0")
      } maximumValueLabel: {
        Text("100")
      } onEditingChanged: { editing in
        // onEditingChangedはスライダー操作開始と終了時に実行されるクロージャ
        isEditing = editing
        print("onEditingChanged:\(sliderVal)(isEditing:\(isEditing))")
        self.logText = self.writeLog(log: "onEditingChanged:\(sliderVal)(isEditing:\(isEditing))\n")
      } .onChange(of: sliderVal) { newV in
        // onChangeはスライダー操作中に常に実行されるクロージャ
        print("onChange:\(sliderVal)")
        self.logText = self.writeLog(log: "onChange:\(sliderVal)\n")
      }
      
      Text("\(sliderVal)")
        .foregroundColor(isEditing ? .red : .blue)
      
      Spacer()
//      LogView(logText: $logText)

      GeometryReader { geometory in
        Text(logText)
          .frame(width: geometory.size.width, height: 400)
          .background(.gray)
          .font(.footnote)
          .lineLimit(20)
      }
      Spacer()
      Button("sliderValを変更(+3)"){
        self.sliderVal += 3
      }
      Spacer()
    }
    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
  func writeLog(log: String) -> String {
    if logArr.count >= self.maxLineCnt - 1 {
      self.logArr.remove(at: 0)
    }
    self.logArr.append(log)
    
    return logArr.joined(separator: "\n")
  }

}

struct LogView: View {
  @Binding var logText: String {
    didSet {
      if logArr.count >= self.maxLineCnt - 1 {
        logArr.remove(at: 0)
      }
      logArr.append(logText)
    }
  }
  @State private var logArr = [String]()
  @State private var maxLineCnt = 10
  var body: some View {
    GeometryReader { geometory in
      Text(logText)
        .frame(width: geometory.size.width, height: 200)
        .background(.gray)
        .font(.footnote)

        .multilineTextAlignment(.leading) // 左寄せ
        .frame(maxWidth: .infinity, alignment: .leading) // 文字列を左寄せにするためにFrameを使用
        .lineLimit(nil) // 複数行のテキストを扱う場合はlineLimit(nil)を使用し、全ての行を表示する
      
        .onChange(of: logText) { newValue in
          logText = writeLog(log: newValue)
        }
    }
  }
  func writeLog(log: String) -> String {
    if logArr.count >= self.maxLineCnt - 1 {
      self.logArr.remove(at: 0)
    }
    self.logArr.append(log)
    
    return logArr.joined(separator: "\n")
  }
}
