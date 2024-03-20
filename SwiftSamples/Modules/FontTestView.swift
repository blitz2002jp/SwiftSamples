//
//  FontTestView.swift
//  SwiftTest
//
//  Created by masazumi oeda on 2024/02/19.
//

import SwiftUI

struct FontTestView: View {
  @Binding var nextView: SwiftTestViews
  @Environment(\.dismiss) var dismiss

  var body: some View {
    Text("FontTestView")
      .font(.title)
    Spacer()
    VStack {
      Text("largeTitle").font(.largeTitle)   // 大きなタイトル
      Text("title").font(.title)             // タイトル
      Text("headline").font(.headline)       // 見出し
      Text("subheadline").font(.subheadline) // 小見出し
      Text("body").font(.body)               // 本文
      Text("callout").font(.callout)         // 吹き出し
      Text("caption").font(.caption)         // キャプション
      Text("footnote").font(.footnote)       // 注釈
    }

    VStack {
      Text("black").fontWeight(.black)
      Text("bold").fontWeight(.bold)
      Text("heavy").fontWeight(.heavy)
      Text("light").fontWeight(.light)
      Text("medium").fontWeight(.medium)
      Text("regular").fontWeight(.regular)
      Text("semibold").fontWeight(.semibold)
      Text("thin").fontWeight(.thin)
      Text("ultraLight").fontWeight(.ultraLight)
    }
    .padding(.top, 10)

    Spacer()
    
    Button("Return"){
      nextView = .topView
    }
  }
}
