//
//  ImageView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/13.
//

import SwiftUI

struct ImageView: View {
  @Binding var nextView: SwiftTestViews

  var body: some View {
    Image(systemName: "cat")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 200, height: 200)
      .foregroundColor(.orange)
      .overlay(Image(systemName: "wind")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 200, height: 200)
        .opacity(0.4)
      )
  }
}
