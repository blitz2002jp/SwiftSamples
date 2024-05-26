//
//  StackView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/05/26.
//

import SwiftUI

struct StackView: View {
  //  @Binding var nextView: SwiftTestViews
  @State private var nextView: SwiftTestViews = .StackView
  @State private var text = ""
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        Capsule()
          .fill(Color(red: 28/255, green: 27/255, blue: 29/255))
          .frame(width:geo.size.width * 0.9, height: 50)
          .opacity(0.2)
      }
      .frame(width: geo.size.width)
    }


    /*
     VStack {
     Button(action: {self.nextView = .topView}, label: {Image(systemName: "return")})
     .padding(.top, 30)
     Spacer()
     ZStack {
     Capsule()
     .fill(Color(red: 28/255, green: 27/255, blue: 29/255)) // RGB値を指定（0.0～1.0）
     .frame(width:400, height: 50)
     .opacity(0.2)
     TextField("テキスト", text: self.$text)
     
     .foregroundStyle(.red)
     //Color(red: 255/255, green: 255/255, blue: 255/255)
     }
     Spacer()
     }
     
     */
  }
}

#Preview {
    StackView()
}
