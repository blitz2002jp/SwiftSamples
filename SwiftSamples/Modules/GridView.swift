//
//  GridView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/12.
//

import SwiftUI

struct GridView: View {
  @Binding var nextView: SwiftTestViews

  var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

  var body: some View {
    VStack {
      Text("Grid Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

      Spacer()

      HStack {
        Text("iOS 14.0の")
          .foregroundStyle(.orange)
        Text("LazyVGrid")
          .foregroundStyle(.red)
      }
        .font(.callout)
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach((0...5), id: \.self) {itm in
            Text("Idx:\(itm)")
          }
        }
      }
      Spacer()
      
      HStack {
        Text("iOS 14.0の")
          .foregroundStyle(.orange)
        Text("LazyHGrid")
          .foregroundStyle(.red)
      }
        .font(.callout)
      ScrollView {
        LazyHGrid(rows: columns) {
          ForEach((0...5), id: \.self) {itm in
            Text("Idx:\(itm)")
          }
        }
      }
      Spacer()
      
      HStack {
        Text("iOS 15.0の")
          .foregroundStyle(.orange)
        Text("Grid")
          .foregroundStyle(.red)
      }
        .font(.callout)
      ScrollView {
        Grid {
          GridRow {
            ForEach((0...2), id: \.self) {itm in
              Text("Idx:\(itm)")
            }
          }
          GridRow {
            ForEach((3...5), id: \.self) {itm in
              Text("Idx:\(itm)")
            }
          }
        }
      }


      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
  }
}
