//
//  PropertyWarpView.swift
//  SwiftTest
//
//  Created by masazumi oeda on 2024/02/13.
//------
/*
 @State
 @Binding
 @Environment
 @EnvironmentObject
 @StateObject
 @ObservedObject
 @Published
 */

import SwiftUI
import Combine

struct PropertyWarpView: View {
  @Binding var nextView: SwiftTestViews
  
  // ②　@Stateテスト用プロパティ
  @State private var stateTestProp = 0
  
  // ③　@Bindingテスト用プロパティ
  @State private var count = 0
  
  // ④　@Environmentテスト　結果表示モーダル表示・非表示
  @State private var isShowEnvRes: Bool = false
  
  // ⑤　@StateObjectと@OvservedObjectテスト　モーダル表示・非表示
  @State private var isShowStateObser: Bool = false

  // ⑥　@Publishedテスト　モーダル表示・非表示
  @State private var isShowPublished: Bool = false

  var body: some View {
    Text("PropertyWarpView")
      .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    Text("Swift 5.1 から追加された機能です。プロパティにカスタムな振る舞いや機能を提供するための仕組。@State,@BindingなどAppleが用意しているものも多数ある。")
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
      .font(.footnote)
    
    Button("①　独自のPropertyWarpper"){
      let example = TestClass()
      print(example.p1) // 50
      
      example.p1 = 200
      print(example.p1) // 999
      
      example.p1 = 0
      print(example.p1) // 1
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    
    // @Stateテスト(stateTestProp変更をSwiftUIが監視して変更されると再描画される)
    Button("②　@Stateテスト") {
      self.stateTestProp += 1
    }
    .padding(.top, 10)
    .frame(maxWidth: .infinity, alignment: .leading)

    Text("stateTestProp : \(self.stateTestProp)")
      .padding(.top, 10)
    
    // @Bindingテスト
    Text("③　@Bindingテスト")
      .padding(.top, 10)
      .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
      .frame(maxWidth: .infinity, alignment: .leading)
    Text("Count in ContentView: \(count)")
    // 子View 表示
    ChildView(count: $count)

    // @Environmentテスト
    Button("④　@Environmentテスト") {
      self.isShowEnvRes = true
    }
      .padding(.top, 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .sheet(isPresented: $isShowEnvRes, onDismiss: { self.isShowEnvRes = false } ) {
        EnvResModalView()
      }
    
    // ⑤ StateObjectとObservedObjectテスト
    Button("⑤ @StateObjectと@ObservedObjectテスト"){
      self.isShowStateObser = true
    }
      .padding(.top, 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .sheet(isPresented: $isShowStateObser, onDismiss: { self.isShowStateObser = false } ) {
        StateOvservParentView()
      }

    // ⑥ Publishedテスト
    Button("⑥ @Publishedテスト"){
      self.isShowPublished = true
    }
      .padding(.top, 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .sheet(isPresented: $isShowPublished, onDismiss: { self.isShowPublished = false } ) {
        PublishedView()
      }

    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}
///------------------------------------------------------------------------------------
///  ①独自のPropertyWarpperを使うClass
///------------------------------------------------------------------------------------
  class TestClass{
    @TestPropertyWarp var p1 = 10
  }
  /// 独自のPropertyWarpper
  @propertyWrapper
  struct TestPropertyWarp {
    var value: Int
    
    init(wrappedValue initialValue: Int) {
      self.value = initialValue
    }
    
    // セットされるプロパティが０より大きいときプロパティは999、それ以外は1
    var wrappedValue: Int {
      get { return value }
      set {
        if newValue > 0 {
          value = 999
        } else {
          value = 1
        }
      }
    }
  }

///------------------------------------------------------------------------------------
/// ②　子Viewと孫View
/// 　　処理の流れ
///       親Viewの中に子Viewを表示
///       子Viewの中に孫Viewを表示
///       孫Viewがボタンを表示
///       孫ViewのボタンタップでBindingされたプロパティをIncliment
///       親ViewでInclimentされたプロパティをTextで表示
///------------------------------------------------------------------------------------
struct ChildView: View {
  // 親View -> 子ViewのプロパティとBinding(関連付け）するプロパティ
    @Binding var count: Int

    var body: some View {
      ChildChildView(count: $count)
    }
}

struct ChildChildView: View {
    // 親View -> 子View -> 孫ViewのプロパティとBinding(関連付け）するプロパティ
    @Binding var count: Int

    var body: some View {
        Button("Increment") {
            self.count += 1
        }
    }
}

///------------------------------------------------------------------------------------
// ④　@Environmeentの結果表示モーダルView
///------------------------------------------------------------------------------------
struct EnvResModalView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Environment(\.locale) var locale: Locale
  @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
  @Environment(\.accessibilityEnabled) var accessibilityEnabled: Bool
  @State var res: String = ""

  var body: some View {
    Text("@Envoronmentテスト")
      .font(.title)
    
    Text("アプリの環境情報にアクセスするプロパティを作成(これ以外にも多数ある）")
      .frame(maxWidth: .infinity, alignment: .leading)
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
      .padding(.top, 10)

    Spacer()

    Text(res)
      .onAppear(){
        self.res = String("colorScheme:\(self.colorScheme)\n")
        self.res += String("locale:\(self.locale)\n")
        self.res += String("sizeCategory:\(self.sizeCategory)\n")
        self.res += String("accessibilityEnabled:\(self.accessibilityEnabled)\n")
      }

    Spacer()
    Button("close") {
      dismiss()
    }
  }
}

///------------------------------------------------------------------------------------
// ⑤ @StateObjectと@OvservedObjectテスト用クラスとView
///------------------------------------------------------------------------------------
class StateOvservViewModel: ObservableObject {
  // @Publishedを付けるとViewへの変更通知が自動で行われる
  @Published var count: Int = 0
}

// 親View
struct StateOvservParentView: View {
  @Environment(\.dismiss) var dismiss
  @State var viewUpdate: Bool = false
  
  var body: some View {
    Text("インクリメント後に「親Viewの表示更新」をタップすると@OvservedObjectはクリアされる")

    Spacer()
    StateChildView()
    OvservChildView()
      .padding(.top, 10)
    Spacer()
    Button("親Viewの表示更新"){
      viewUpdate.toggle()
    }
    viewUpdate == true ?
    Text("🐈").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    :
    Text("🐶").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    Spacer()
    
    Button("close") {
      dismiss()
    }
  }
}

// @StateObjectと定義した子View
struct StateChildView: View {
  // @StateObjectでモデルのインスタンスを宣言
  @StateObject private var vModel = StateOvservViewModel()
  
  var body: some View {
    
    Text("@StateObjectのインスタンス使用した子View")
    HStack{
      Button(action: {
        vModel.count += 1
      }, label: {
        Image(systemName: "plus")
      })
      .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
      
      Text("\(vModel.count)")
    }
  }
}

// @ObservedObjectと定義した子View
struct OvservChildView: View {
  // @ObservedObjectでモデルのインスタンスを宣言
  @ObservedObject private var vModel = StateOvservViewModel()
  
  var body: some View {
    Text("@ObservedObjectのインスタンス使用した子View")
    HStack{
      Button(action: {
        vModel.count += 1
      }, label: {
        Image(systemName: "plus")
      })
      .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
      
      Text("\(vModel.count)")
    }
  }
}

///------------------------------------------------------------------------------------
// ⑥ @Publishedテスト用クラスとView
///------------------------------------------------------------------------------------
class PublishedViewModel: ObservableObject {
  // @Publishedを付けるとViewへの変更通知が自動で行われる
  @Published var count: Int = 0
  var subViewModel = SubViewModel()
  @Published var subStructViewModel = SubStructModel()
}

class SubViewModel { //: ObservableObject {
  var prop1: Int = 0
}

struct SubStructModel{
  var prop2: Int = 0
}

// View
struct PublishedView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject private var viewModel = PublishedViewModel()
  @ObservedObject private var utl = Utility()
  @StateObject var publishedViewModel = PublishedViewModel2()

  
  var body: some View {
    VStack{
      Text("@Publishedによる画面描画の通知テスト")
      Spacer()
      Text("ViewModelの各プロパティの変更通知のテスト")
        .padding(.bottom, 40)
      HStack{
        Button("① Int型プロパティ変更:"){
          self.viewModel.count += 1
        }
        Text(":\(self.viewModel.count)")
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding(.leading, 20).padding(.bottom, 10)
      
      HStack{
        Button("② Class型プロパティ変更:"){
          self.viewModel.subViewModel.prop1 += 1
        }
        Text("\(self.viewModel.subViewModel.prop1)")
        Button(
          action: {
            utl.reDraw()
          },
          label: {
          Image(systemName: "arrow.clockwise")
        })
        Text("(再描画)").foregroundStyle(.red)
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding(.leading, 20).padding(.bottom, 10)
      
      HStack{
        Button("③ Struct型プロパティ変更:"){
          self.viewModel.subStructViewModel.prop2 += 1
        }
        Text("\(self.viewModel.subStructViewModel.prop2)")
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding(.leading, 20)

      VStack{
        Text("④ Published型プロパティ変更:")
          .foregroundStyle(.blue)

        HStack {
          Text("@Publishedのプロパティ")
          Button(action: {
            print("tap1")
          })
          {
            // 表示を切り替える
            if self.publishedViewModel.publishProp == true {
              Image(systemName: "sun.haze")
                .imageScale(.large)
            } else {
              Image(systemName: "cloud")
                .imageScale(.large)
            }
          }
          Button("Tap") {
            self.publishedViewModel.publishProp.toggle()
          }
        }
        .padding(.bottom, 40)
        

        HStack {
          Text("@Publishedではないプロパティ")
          Button(action: {
            print("tap2")
          })
          {
            // 表示を切り替える
            if self.publishedViewModel.noPublishProp == true {
              Image(systemName: "sun.horizon.fill")
                .imageScale(.large)
            } else {
              Image(systemName: "cloud.snow.fill")
                .imageScale(.large)
            }
          }
          Button("Tap") {
            self.publishedViewModel.noPublishProp.toggle()
          }
        }
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding(.leading, 20)

      VStack{
        Text("・①、③は,@Publishedでプロパティを定義することで自動更新される。")
        Text("・②は,Class型なので自動更新されない。１つの方法として強制的に再描画させられる。")
          //.multilineTextAlignment(.trailing)
      }
      .border(Color.black)
      .font(.footnote)
      .padding(.top, 10)

      Spacer()
      
      Button("close") {
        dismiss()
      }
    }
  }
}

class Utility: ObservableObject {

  func reDraw(){
    objectWillChange.send()
    print("reDraw")
  }
}


class PublishedViewModel2: ObservableObject {
  @Published var publishProp = false
  var noPublishProp = false
}
