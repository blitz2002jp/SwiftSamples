//
//  PickerView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/02.
//

import SwiftUI

struct PickerView: View {
  @Binding var nextView: SwiftTestViews
  @State private var selectedItem1: String = ""
  @State private var selectedItem2: String = ""
  @State private var selectedItem3: String = ""
  @State private var selectedItem4: String = ""
  
  @State private var newItem: String = ""
  
//  private var items = ["New Item", "Item 1", "Item 2", "Item 3"]
  
  var body: some View {
    VStack {
      Text("Picker Test")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Spacer()
      
      // メニュー型Picker
      Picker("項目を選択", selection: $selectedItem1) {
        Text("New Item").tag("NewItem")
        Text("Item 1").tag("Item1")
        Text("Item 2").tag("Item2")
/*
        ForEach(items, id: \.self) {
          Text($0)
        }
 */
      }
      HStack {
        Text("選択されて項目:")
        if self.selectedItem1 == "NewItem" {
          TextField("new item", text: self.$newItem)
        } else {
          Text("\(self.selectedItem1)")
            .foregroundStyle(.red)
        }
      }
      
      Spacer()
      
      // ホイール型Picker
      Picker("項目を選択", selection: $selectedItem2) {
        Text("New Item").tag("NewItem")
        Text("Item 1").tag("Item1")
        Text("Item 2").tag("Item2")
      }
      .pickerStyle(.wheel)
      HStack {
        Text("選択された項目:")
        Text("\(self.selectedItem2)")
          .foregroundStyle(.red)
      }
      
      Spacer()
      
      // セグメント型Picker
      Picker("項目を選択", selection: $selectedItem3) {
        Text("New Item").tag("NewItem")
        Text("Item 1").tag("Item1")
        Text("Item 2").tag("Item2")
      }
      .pickerStyle(.segmented)
      HStack {
        Text("選択されて項目:")
        Text("\(self.selectedItem3)")
          .foregroundStyle(.red)
      }
      
      Spacer()
      
      // Inline型Picker
      Form{
        Picker("項目を選択", selection: $selectedItem4) {
          Text("New Item").tag("NewItem")
          Text("Item 1").tag("Item1")
          Text("Item 2").tag("Item2")
        }
        .pickerStyle(.inline)
        
      }
      
      HStack {
        Text("選択されて項目:")
        Text("\(self.selectedItem4)")
          .foregroundStyle(.red)
      }
      
      // 戻るボタン
      Spacer()
      Button("Return"){
        nextView = .topView
      }
    }
    // メニュー型PickerのonChangeモディファイア
    .onChange(of: self.selectedItem1) { newItem in
      print("Selected Item:\(newItem)")
    }
    // ホイール型PickerのonChangeモディファイア
    .onChange(of: self.selectedItem2) { newItem in
      print("Selected Item:\(newItem)")
    }
    // セグメント型PickerのonChangeモディファイア
    .onChange(of: self.selectedItem3) { newItem in
      print("Selected Item:\(newItem)")
    }
    // Inline型PickerのonChangeモディファイア
    .onChange(of: self.selectedItem4) { newItem in
      print("Selected Item:\(newItem)")
    }

  }
}
