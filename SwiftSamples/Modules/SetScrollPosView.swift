//
//  SetScrollPosView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/08.
//

import SwiftUI

struct SetScrollPosView: View {
  @Binding var nextView: SwiftTestViews
  @State var items = [SetScrollPosItem]()
  @State var index = 0
  @State var indexStr = ""
  @State var showLine: CGFloat = 1
  @State var hideine: CGFloat = 0
  @State var anchorIndex = 0


  var body: some View {
    VStack {
      Text("SetScrollPos Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Spacer()
      
      
      ScrollViewReader { proxy in
        ScrollView {
          ForEach(self.items, id: \.id) { item in
            VStack {
              Text(item.name)
                .padding([.leading, .trailing, .top, .bottom], 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: item.id == index ? showLine : hideine) // 枠線を描画
                )
            }
          }
        }

        HStack{
          Button(action: {
            self.index = max(self.index - 1, 0)
            proxy.scrollTo(index)
          }) {
            Image(systemName: "arrow.up")
          }
          Spacer()
          TextField("", text: self.$indexStr)
            .keyboardType(.numberPad)
            .background(.red)
            .frame(width: 40)
          
          Button("1") {
            self.index = Int(self.indexStr)!
            proxy.scrollTo(index, anchor: .top)
          }
          Button("2") {
            self.index = Int(self.indexStr)!
            proxy.scrollTo(index, anchor: .bottom)
          }
          Button("3") {
            self.index = Int(self.indexStr)!
            proxy.scrollTo(index, anchor: .bottomLeading)
          }
          Button("4") {
            self.index = Int(self.indexStr)!
            proxy.scrollTo(index, anchor: .bottomTrailing)
          }
          Button("5") {
            self.index = Int(self.indexStr)!
            proxy.scrollTo(index, anchor: .center)
          }
          Spacer()
          Button(action: {
            self.index = min(self.index + 1, 49)
            print("index:\(self.index)")
            proxy.scrollTo(index)
          }) {
            Image(systemName: "arrow.down")
          }
        }
      }

      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
    .onAppear() {
      for i in 0..<50 {
        self.items.append(SetScrollPosItem(id: i, name: "Name_\(i)"))
      }
    }
  }
}

class SetScrollPosItem { //}: Identifiable {
  var id = 0
  var name = ""
  init(id: Int, name: String = "") {
    self.id = id
    self.name = name
  }
}
