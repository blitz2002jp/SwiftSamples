//
//  SelectList.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/07/01.
//

import SwiftUI

struct SelectList: View {
  private let items = ["大谷", "中谷", "小谷"]

  @State private var selectedItems1: Set<Int> = []

  @State private var selectedItems2: Set<Int> = []
  @State private var oldSelection2: Set<Int> = []

  @State private var selectedItems3: Set<Int> = []
  @State private var oldSelection3: Set<Int> = []

  var body: some View {
    VStack {
      // 複数選択
      List(selection: $selectedItems1) {
        Section {
          ForEach(items.indices, id: \.self) { index in
            Text(items[index]).tag(index)
          }
        } header: {
          HStack{
            Text("複数選択")
            ForEach(Array(self.selectedItems1), id: \.self) { item in
              Text(self.items[item])
                .foregroundStyle(.red)
            }
          }
        }
      }
      .environment(\.editMode, .constant(.active))

      // 単一選択（iOS 17.0以前)
      List(selection: $selectedItems2) {
        Section {
          ForEach(items.indices, id: \.self) { index in
            Text(items[index]).tag(index)
          }
        } header: {
          HStack{
            Text("単一選択（iOS 17.0以前）")
            Text("\(self.selectedItems2.first  == nil ? "" : items[self.selectedItems2.first!])")
              .foregroundStyle(.red)
          }
        }
      }
      .environment(\.editMode, .constant(.active))
      .onChange(of: selectedItems2) { newSelection in
        if self.oldSelection2.count > 0 {
          if let _oldItem = self.oldSelection2.first {
            selectedItems2.remove(_oldItem)
            self.oldSelection2 = []
            return
          }
        }
        self.oldSelection2 = newSelection
      }
      
      // 単一選択（iOS 17.0以降)
      List(selection: $selectedItems3) {
        Section {
          ForEach(items.indices, id: \.self) { index in
            Text(items[index]).tag(index)
          }
        } header: {
          HStack {
            Text("単一選択（iOS 17.0以降)")
            Text("\(self.selectedItems3.first  == nil ? "" : items[self.selectedItems3.first!])")
              .foregroundStyle(.red)
          }
        }
      }
      .environment(\.editMode, .constant(.active))
      .onChange(of: selectedItems3) { oldSelection, newSelection in
        guard let toBeUnchecked = oldSelection.first else {
          return
        }
        if newSelection.count <= 1 {
          return
        }
        selectedItems3.remove(toBeUnchecked)
      }
    }
  }
}
