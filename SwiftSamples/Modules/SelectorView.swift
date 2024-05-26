//
//  SelectorView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/21.
//
import SwiftUI

struct SelectorView: View {
    @Binding var nextView: SwiftTestViews
    
    @State private var selectedItem: YourItemClass = YourItemClass(name: "Item 1")
    @State private var items: [YourItemClass] = [
        YourItemClass(name: "Item 1"),
        YourItemClass(name: "Item 2"),
        YourItemClass(name: "Item 3")
    ]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedItem, label: Text("Select Item")) {
                ForEach(items, id: \.self) { item in
                    Text(item.name).tag(item)
                }
            }
            .pickerStyle(.menu)
          Spacer()

            Text("Selected Item: \(selectedItem.name)")

          Button("sel") {
            selectedItem = items[0]
          }
          Button("sel") {
            selectedItem = items[1]
          }
          Button("sel") {
            selectedItem = items[2]
          }
          
          /*
           
           */
          
        }
    }
}

class YourItemClass: Identifiable, Hashable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: YourItemClass, rhs: YourItemClass) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
