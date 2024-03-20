//
//  ContentView.swift
//  SwiftSample
//
//  Created by masazumi oeda on 2024/02/20.
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
  case TestEtcView          // その他のテストView
  case Test2View            // テスト2View
}

struct ContentView: View {
  @State private var testView: SwiftTestViews = .topView
  var menuColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

  var body: some View {
    switch testView {
    case .topView:
      Spacer()
      ScrollView {
        LazyVGrid(columns: menuColumns, spacing: 30) {
          Text("Property Warppers")
            .onTapGesture{
              testView = .PropertyWarp
            }

          Text("Swift Argument")
            .onTapGesture{
              testView = .Argument
            }
          Text("ローカルストレージ")
            .onTapGesture{
              testView = .UserDefaults
            }
          Text("ModalView")
            .onTapGesture{
              testView = .ModalView
            }
          Text("Font")
            .onTapGesture{
              testView = .FontView
            }
          Text("Multi Thread")
            .onTapGesture{
              testView = .MultiThreadView
            }
          Text("Selector")
            .onTapGesture{
              testView = .SelectorView
            }
          Text("Delegate")
            .onTapGesture{
              testView = .DelegateView
            }
          Text("TryCatch")
            .onTapGesture{
              testView = .TryCatchView
            }
          Text("Slider")
            .onTapGesture{
              testView = .SliderView
            }
          Text("Picker")
            .onTapGesture{
              testView = .PickerView
            }
          Text("Swift Unique")
            .onTapGesture{
              testView = .SwiftUniqueView
            }
          Text("Set Scroll Pos")
            .onTapGesture{
              testView = .SetScrollPosView
            }
          Text("ARC")
            .onTapGesture{
              testView = .ArcView
            }
          Text("OptionalType")
            .onTapGesture{
              testView = .OptionalTypeView
            }
          Text("TestEtc")
            .onTapGesture{
              testView = .TestEtcView
            }
          Text("Test2 View")
            .onTapGesture{
              testView = .Test2View
            }
          Text("Grid View")
            .onTapGesture{
              testView = .GridTestView
            }
          Text("Navigation View")
            .onTapGesture{
              testView = .NavigationView
            }
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
    case .TestEtcView:
      TestEtcView(nextView: $testView)
    case .Test2View:
      Test2View(nextView: $testView)
    case .GridTestView:
      GridView(nextView: $testView)
    case .NavigationView:
      NavigationViewTest(nextView: $testView)
    }
  }
}

#Preview {
    ContentView()
}
