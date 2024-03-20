//
//  ModalView.swift
//  SwiftTest
//
//  Created by masazumi oeda on 2024/02/16.
//

import SwiftUI

/// ①②SheetのViewモデル
class ViewModel : ObservableObject {
  @Published var title: String

  init(title: String) {
    self.title = title
  }
}
/// ①SheetのItem用モデル
class SheetModel1 {
  var title: String

  init(title: String) {
    self.title = title
  }
}
/// ②SheetのItem用モデル
class SheetModel2 : Identifiable {
  var title: String

  init(title: String) {
    self.title = title
  }
}

/// ModalMainView
struct ModalMainView: View {
  @Binding var nextView: SwiftTestViews
  @State private var isShowSheet1 = false
  @State private var isShowSheet2 = false
  @State private var isShowFullScreenCov = false
  @State private var isShowSheetMulti = false
  
  @State private var sheetModel1: SheetModel1?
  @StateObject private var viewModel1 = ViewModel(title: "①タイトル初期値")
  @State private var sheetModel2: SheetModel2?
  @StateObject private var viewModel2 = ViewModel(title: "②タイトル初期値")
  @State private var sheetModel3: SheetModel1?
  @StateObject private var viewModel3 = ViewModel(title: "③タイトル初期値")

  
  var body: some View {
    Text("ModalView")
      .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    
    Button("①　Sheet(isPresented)"){
      self.isShowSheet1 = true
      // ViewModelのTitleをSheetModelへセットしインスタンス作成
      self.sheetModel1 = SheetModel1(title: self.viewModel1.title)
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    // Sheet表示
    .sheet(isPresented: $isShowSheet1, onDismiss: {
      
      self.isShowSheet1 = false
    }) {
      ModalView(viewModel: viewModel1)
    }
    Text(self.viewModel1.title)

    Button("②　Sheet(item)") {
      // ViewModelのTitleをSheetModelへセットしインスタンス作成
      self.sheetModel2 = SheetModel2(title: self.viewModel2.title)
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    /// URL : https://capibara1969.com/2521/
    .sheet(item: $sheetModel2) { item in
      SheetItemView(model: item, onDismiss: { updateItem in
        // Sheetで更新したTitleをViewModelにセット
        self.viewModel2.title = updateItem?.title ?? ""
      })
    }
    Text(self.viewModel2.title)

    Button("③　fullScreenCover"){
      isShowFullScreenCov = true
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    // fullScreenCover表示(表示方法は他にも多数ある）
    .fullScreenCover(isPresented: $isShowFullScreenCov, onDismiss: { isShowFullScreenCov = false }) {
      ModalView(viewModel: viewModel3)
    }
    Text(self.viewModel3.title)

    Button("④　Sheet（複数)"){
      isShowSheetMulti = true
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    // Sheet表示(表示方法は他にも多数ある）
    .sheet(isPresented: $isShowSheetMulti, onDismiss: { self.isShowSheetMulti = false }) {
      ModalMultiView1()
    }

    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }

  /// ②のDismissハンドラー
  func didDismiss() {
      // Handle the dismissing action.
    print("PRINT2:\(self.sheetModel2?.title ?? "void")")
  }

}

struct ModalView: View {
  @ObservedObject var viewModel: ViewModel
  @Environment(\.dismiss) var dismiss

  var body: some View {
    HStack {
      Button("Cancel"){
        dismiss()
      }
      Spacer()
      Button("OK"){
        dismiss()
      }
    }
    .padding(.top, 50)
    .padding([.leading, .trailing], 30)
    Spacer()
    TextField("", text: self.$viewModel.title)
    Spacer()
  }
}

struct ModalMultiView1: View {
  @State private var isShowSheetMulti1 = false
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text("Modal View Multi 1")
      .font(.title)
    Text("モーダルViewからモーダルViewを開く")
      .font(.footnote)
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
      .padding(.top, 10)

    Spacer()
    
    Button("Show Modal") {
      self.isShowSheetMulti1 = true
    }
    .sheet(isPresented: $isShowSheetMulti1, onDismiss: { self.isShowSheetMulti1 = false }) {
      ModalMultiView2()
    }
    
    Spacer()
    
    Button("Close"){
      dismiss()
    }
    
    Spacer()
    
  }
}

struct ModalMultiView2: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    Text("Modal View Multi 2")
      .font(.title)

    Spacer()

    Button("Close"){
      dismiss()
    }

    Spacer()

  }
}

/// ②用SheetView
struct SheetItemView: View {
  @State var model: SheetModel2
//  @State private var inputItem1: String = ""
  @Environment(\.dismiss) var dismiss
  var onDismiss: (SheetModel2?) -> Void

  var body: some View {
    VStack {
      HStack {
        Button("Cancel"){
          dismiss()
        }
        Spacer()
        Button("OK"){
//          self.model.title = self.inputItem1
          dismiss()
          onDismiss(model)
        }
      }
      .padding(.top, 50)
      .padding([.leading, .trailing], 30)
      
      Spacer()
      
//      TextField("Title", text: $inputItem1)
      TextField("Title", text: $model.title )
        .onAppear(){
//          self.inputItem1 = model.title
        }
      Spacer()
    }
  }
}
