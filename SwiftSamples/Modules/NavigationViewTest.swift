//
//  NvigationView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/03/13.
//

import SwiftUI

struct NavigationViewTest: View {
  @Binding var nextView: SwiftTestViews
  @State var showSubView1 = false
  @State var showSubView2 = false
  @State var showSubView3 = false
  @State var showSubView4 = false

  var body: some View {
    Spacer()
    Button("非推奨タイトル表示") {
      self.showSubView1.toggle()
    }
    .sheet(isPresented: $showSubView1, content: {
      NavigationTest1View()
    })
    Spacer()
    Button("タイトル(Default)") {
      self.showSubView2.toggle()
    }
    .sheet(isPresented: $showSubView2, content: {
      NavigationTest2View()
    })
    Spacer()
    Button("タイトル(InLine)") {
      self.showSubView3.toggle()
    }
    .sheet(isPresented: $showSubView3, content: {
      NavigationTest3View()
    })
    Spacer()
    Button("タイトル(ToolBar)") {
      self.showSubView4.toggle()
    }
    .sheet(isPresented: $showSubView4, content: {
      NavigationTest4View()
    })
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}

struct NavigationTest1View: View {
  @State var isLinkActive = false
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: NavigationTest1View(), isActive: $isLinkActive) {
          Text("Navigation View Test1")
        }
      }
      // 非推奨
      .navigationBarTitle("タイトル(非推奨)", displayMode: .inline)
      .navigationBarItems(leading: Button("戻る"){dismiss()})
    }
    Text("タイトル表示にiOS13以降非推奨のnavigationBarTitleを使用")
      .padding(5)
  }
}

struct NavigationTest2View: View {
  @State var isLinkActive = false
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: NavigationTest1View(), isActive: $isLinkActive) {
          Text("Navigation View Test1")
        }
      }
      .navigationTitle("タイトル(Default)")
      .navigationBarItems(leading: Button("戻る"){dismiss()})
    }
    Text("タイトル表示にnavigationTitleを使用しデフォルト表示")
      .padding(5)
  }
}

struct NavigationTest3View: View {
  @State var isLinkActive = false
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: NavigationTest1View(), isActive: $isLinkActive) {
          Text("Navigation View Test1")
        }
      }
      .navigationTitle("タイトル(InLine)")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(leading: Button("戻る"){dismiss()})
    }
    Text("タイトル表示にnavigationTitleを使用し,インライン表示")
      .padding(5)
  }
}
struct NavigationTest4View: View {
  @State var isLinkActive = false
  @State var flg = 0
  @Environment(\.dismiss) var dismiss
  var body: some View {
      NavigationView {
        List {
          NavigationLink(destination: NavigationTest1View(), isActive: $isLinkActive) {
            Text("Navigation View Test1")
          }
        }
        .toolbar {
          ToolbarItem(placement: .principal) {
            Text("タイトル(Toolbar)")
              .font(.footnote)
          }
        }
        .navigationBarItems(leading: Button("戻る"){dismiss()})
      }
      Text("タイトル表示にToolbarを使用しフォントも指定")
        .padding(5)
    }
}

struct NavigationSub1View: View {
  var body: some View {
    Text("1")
  }
}

struct NavigationSub2View: View {
  var body: some View {
    Text("2")
  }
}
