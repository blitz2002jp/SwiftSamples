//
//  GeometryReaderBugView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/05/26.
//

import SwiftUI

struct GeometryReaderBugView: View {
  //@Binding var nextView: SwiftTestViews

  var body: some View {
    VStack {
      Text("GeometryReaderを使用すると座標がズレる")
        .font(.title2)
      
      VStack {
        Text("修正前")
          .font(.title3)
        GeometryReader { geo in
          VStack {
            Rectangle()
              .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
          }
        }
      }

      Text("修正後")
        .font(.title3)
      VStack {
        GeometryReader { geo in
          VStack {
            Rectangle()
              .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
          }
          .frame(width: geo.size.width)
        }
      }
    }
  }
}

#Preview {
  GeometryReaderBugView()
}
