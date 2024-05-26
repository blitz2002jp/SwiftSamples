//
//  AppleBUG.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/05/14.
//

import SwiftUI

struct AppleBUG: View {
  @Binding var nextView: SwiftTestViews
  @State private var effectFlg = false
  private let imageName = "image1"
  @State var rotationDegrees = 0.0
  
  private let imageSize = CGSize(width: 50, height: 50)
  
  var body: some View {
    ScrollView {
      VStack() {
        Text("Rectangle")
        Rectangle()
          .foregroundColor(.blue)
          .frame(width: imageSize.width, height: imageSize.height)
          .padding(.bottom, 30)
        
        Text("PNG Image")
        if let _imageName = Bundle.main.path(forResource: imageName, ofType: "png") {
          Image(uiImage: UIImage(contentsOfFile: _imageName)!)
            .resizable()
            .frame(width: imageSize.width, height: imageSize.height)
            .padding(.bottom, 30)
        }
        Text("PNG Image")
        if let _imageName = Bundle.main.path(forResource: imageName, ofType: "png") {
          Image(uiImage: UIImage(contentsOfFile: _imageName)!)
            .resizable()
            .frame(width: imageSize.width, height: imageSize.height)
            .padding(.bottom, 30)
        }
        Text("PNG Image")
        if let _imageName = Bundle.main.path(forResource: imageName, ofType: "png") {
          Image(uiImage: UIImage(contentsOfFile: _imageName)!)
            .resizable()
            .frame(width: imageSize.width, height: imageSize.height)
            .padding(.bottom, 30)
        }
        
        
        Text("PNG Image")
        if let _imageName = Bundle.main.path(forResource: imageName, ofType: "png") {
          Image(uiImage: UIImage(contentsOfFile: _imageName)!)
            .resizable()
            .frame(width: imageSize.width, height: imageSize.height)
          //          .scaleEffect(self.effectFlg ? 1 : 0.8)
            .rotationEffect(.degrees(self.rotationDegrees))
        }
      }
    }
    Spacer()
    Button(action: {
      withAnimation(.default.repeatForever().speed(0.5)) {

        if self.effectFlg {
          rotationDegrees = 360.0
        } else {
          rotationDegrees = 360.0
        }
        
        rotationDegrees = 360.0
        self.effectFlg.toggle()
        
      }}, label: {
        Image(systemName: "play")})
  }
}


