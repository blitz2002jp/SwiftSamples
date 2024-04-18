//
//  ContentView2.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/03/25.
//

import SwiftUI
enum SwiftTestViews: String{
  case topView
  case PropertyWarp         // Property Warppersのテスト
  case Argument             // Swiftのメソッドへの引数渡し方テスト
  case UserDefaults         // UserDefaultsの使い方
  case ModalView            // モーダルViewの表示
  case FontView             // フォントViewの表示
  case MultiThreadView      // マルチスレッドテスト
  case SelectorView         // Selectorテスト
  case DelegateView         // DelegateViewテスト
  case TryCatchView         // TryCatchViewテスト
  case SliderView           // SliderViewテスト
  case PickerView           // PickerViewテスト
  case SwiftUniqueView      // SwiftUniqueViewテスト
  case SetScrollPosView     // SetScrollPosViewテスト
  case ArcView              // ARCテスト
  case OptionalTypeView     // オプショナル型テストView
  case GridTestView         // グリッドテストView
  case NavigationView       // NavigationViewテスト
  case JsonView             // JsonViewテスト
  case ConfirmationDialogView // ConfirmationDialogテスト
  case TapEvent             // タップテスト
  case TestEtcView          // その他のテストView
  case Test2View            // テスト2View
  case MessaveBoxView       // メッセージボックス
  case AnimationSfSymbolView  // SF Symbol アニメーション
  case MP3FileView          // MP3 File View
  case ImageView            // Image View
  case RedrawView           // Redraw View
  case WithAnimationView    // WithAnimation View
  case SwiftBlock           // Swift Block
}


struct ContentView2: View {
  @State private var testView: SwiftTestViews = .topView
  
  var body: some View {
    switch testView {
    case .topView:
      List {
        Section {
          Text("Property Warppers")
            .onTapGesture {
              testView = .PropertyWarp
            }
          Text("Swift Argument")
            .onTapGesture {
              testView = .Argument
            }
          Text("ローカルストレージ")
            .onTapGesture {
              testView = .UserDefaults
            }
          Text("Multi Thread")
            .onTapGesture {
              testView = .MultiThreadView
            }
          Text("Delegate")
            .onTapGesture {
              testView = .DelegateView
            }
          Text("TryCatch")
            .onTapGesture {
              testView = .TryCatchView
            }
          Text("ARC")
            .onTapGesture {
              testView = .ArcView
            }
          Text("OptionalType")
            .onTapGesture {
              testView = .OptionalTypeView
            }
          Text("Json")
            .onTapGesture {
              testView = .JsonView
            }
          Text("MP3 File")
            .onTapGesture {
              testView = .MP3FileView
            }
          Text("Swift Block")
            .onTapGesture {
              testView = .SwiftBlock
            }
        } header: {
          Text("Swiftプログラミング")
        }
        
        Section {
          Text("Swift Unique")
            .onTapGesture{
              testView = .SwiftUniqueView
            }
        } header: {
          Text("Swiftのバグ")
        }
        
        Section {
          Text("ModalView")
            .onTapGesture{
              testView = .ModalView
            }
        } header: {
          Text("Modal")
        }
        
        Section {
          Text("Selector")
            .onTapGesture{
              testView = .SelectorView
            }
          Text("Slider")
            .onTapGesture{
              testView = .SliderView
            }
          Text("Picker")
            .onTapGesture{
              testView = .PickerView
            }
        } header: {
          Text("Data Selector")
        }
        
        Section {
          Text("ConfirmationDialog View")
            .onTapGesture{
              testView = .ConfirmationDialogView
            }
          Text("MessageBox")
            .onTapGesture {
              testView = .MessaveBoxView
            }
        } header: {
          Text("確認")
        }
        
        Section {
          Text("Tap")
            .onTapGesture{
              testView = .TapEvent
            }
        } header: {
          Text("イベント")
        }
        
        Section {
          Text("Grid View")
            .onTapGesture{
              testView = .GridTestView
            }
          Text("Navigation View")
            .onTapGesture{
              testView = .NavigationView
            }
          
          Text("Font")
            .onTapGesture{
              testView = .FontView
            }
          
          Text("Image")
            .onTapGesture{
              testView = .ImageView
            }
          
          Text("Redeaw")
            .onTapGesture() {
              testView = .RedrawView
            }
        } header: {
          Text("表示")
        }
      
        Section {
          Text("Animation SF Symbol")
            .onTapGesture{
              testView = .AnimationSfSymbolView
            }
          Text("WithAnimation")
            .onTapGesture{
              testView = .WithAnimationView
            }
        } header: {
          Text("アニメーション")
        }

        Section {
          Text("TestEtc")
            .onTapGesture{
              testView = .TestEtcView
            }
          Text("Test2 View")
            .onTapGesture{
              testView = .Test2View
            }
        } header: {
          Text("etc")
        }
      }
    case .PropertyWarp:
      PropertyWarpView(nextView: $testView)
    case .Argument:
      ArgumentView(nextView: $testView)
    case .UserDefaults:
      UserDefaultsView(nextView: $testView)
    case .ModalView:
      ModalMainView(nextView: $testView)
    case .FontView:
      FontTestView(nextView: $testView)
    case .MultiThreadView:
      MultiThreadView(nextView: $testView)
    case .SelectorView:
      SelectorView(nextView: $testView)
    case .DelegateView:
      DelegateView(nextView: $testView)
    case .TryCatchView:
      TryCatchView(nextView: $testView)
    case .SliderView:
      SliderView(nextView: $testView)
    case .PickerView:
      PickerView(nextView: $testView)
    case .SwiftUniqueView:
      SwiftUniqueView(nextView: $testView)
    case .SetScrollPosView:
      SetScrollPosView(nextView: $testView)
    case .ArcView:
      ArcView(nextView: $testView)
    case .OptionalTypeView:
      OptionalTypeView(nextView: $testView)
    case .TapEvent:
      TapEventView(nextView: $testView)
    case .TestEtcView:
      TestEtcView(nextView: $testView)
    case .Test2View:
      Test2View(nextView: $testView)
    case .GridTestView:
      GridView(nextView: $testView)
    case .NavigationView:
      NavigationViewTest(nextView: $testView)
    case .JsonView:
      JsonView(nextView: $testView)
    case .ConfirmationDialogView:
      ConfirmationDialogView(nextView: $testView)
    case .MessaveBoxView:
      MessageBox(nextView: $testView)
    case .AnimationSfSymbolView:
      AnimationView(nextView: $testView)
    case .MP3FileView:
      MP3File(nextView: $testView)
    case .ImageView:
      ImageView(nextView: $testView)
    case .RedrawView:
      ReDrawView(nextView: $testView)
    case .WithAnimationView:
      WithAnimationView(nextView: $testView)
    case .SwiftBlock:
      SwiftBlock(nextView: $testView)
    }
  }
}

