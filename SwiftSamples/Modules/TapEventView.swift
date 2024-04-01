//
//  TapEventView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/28.
//

import SwiftUI

struct TapEventView: View {
  @Binding var nextView: SwiftTestViews
  
  @State var color1: Color = .black
  @State var color2: Color = .black
  @State var colorTogle1 = false
  
  var body: some View {
    VStack {
      HStack {
        Text("このテキストのTapに反応")
      }
      .frame(width: 200, height: 200)
      .background(RoundedRectangle(cornerRadius: 1)
      .stroke(self.color1, lineWidth: 5))
      .onTapGesture {
        self.colorTogle1.toggle()
        if self.colorTogle1 {
          self.color1 = .blue
        } else {
          self.color1 = .black
        }
      }
      .padding(.bottom, 20)
      HStack {
        Text("枠内のTapに反応")
      }
      .frame(width: 200, height: 200)
      .background(RoundedRectangle(cornerRadius: 40).stroke(self.color2, lineWidth: 5)
      )
      .contentShape(RoundedRectangle(cornerRadius: 40))
      .onTapGesture {
        self.colorTogle1.toggle()
        if self.colorTogle1 {
          self.color2 = .blue
        } else {
          self.color2 = .black
        }
      }
      Spacer()
      Button("Close") {
        self.nextView = .topView
      }
    }
  }
}
