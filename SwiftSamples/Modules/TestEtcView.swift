//
//  TestEtcView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/28.
//

import SwiftUI

struct TestEtcView: View {
  @Binding var nextView: SwiftTestViews
  @Namespace var topID
  @Namespace var bottomID
  var body: some View {
    
    ScrollViewReader { proxy in

      Button("Scroll to Bottom") {
        withAnimation {
          proxy.scrollTo(bottomID)
        }
      }
      .id(topID)

      ScrollView {
        
        
        VStack(spacing: 0) {
          ForEach(0..<100) { i in
            Text("\(i)")
//            color(fraction: Double(i) / 100)
//              .frame(height: 10)
          }
        }
        
        
        Button("Top") {
          withAnimation {
            proxy.scrollTo(topID)
          }
        }
        .id(bottomID)
      }
    }
  }
  
  
  func color(fraction: Double) -> Color {
    Color(red: fraction, green: 1 - fraction, blue: 0.5)
  }
}
