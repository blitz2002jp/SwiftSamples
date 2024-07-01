//
//  CustomModifierView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/06/23.
//

import SwiftUI

struct CustomModifierView: View {
  var body: some View {
    Text("表示を検知したいView")
      .onActive {
        print("文章表示")
        utility.writeStringToFile(content: "onActive")
      } onInactive: {
        print("文章非表示")
        utility.writeStringToFile(content: "onInactive")
      }
  }
}

//Viewの拡張
extension View {
  /// View表示時の処理をアプリサスペンドにも紐づける
  /// - Parameter onActive: 画面表示時・アプリフォアグラウンド復帰時の処理
  /// - Parameter onInactive: 画面非表示時・アプリサスペンド時の処理
  func onActive(_ onActive: @escaping () -> Void, onInactive: (() -> Void)? = nil) -> some View {
    return self
      .onAppear(perform: onActive)
      .onDisappear(perform: onInactive)
      .modifier(ScenePhaseReader(onSuspend: onInactive, onResume: onActive))
  }
}

        /// アプリサスペンド時にコールバックを実行する
/// - Parameter onSuspend: アプリサスペンド時の処理
/// - Parameter onResume: アプリフォアグラウンド復帰時の処理

struct ScenePhaseReader: ViewModifier {
    /// アプリサスペンド時の処理
    var onSuspend: (() -> Void)? = nil
    /// アプリフォアグラウンド復帰時の処理
    var onResume: (() -> Void)? = nil
    /// アプリのアクティブ状態
    @Environment(\.scenePhase) private var scenePhase
    /// アプリがサスペンド状態か
    @State private var isSuspended = false
    /// 要素が表示中か
    @State private var isPresented = false

    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) { newScenePhase in
                if !isPresented {
                    return
                }
                switch newScenePhase {
                case .active:
                    if scenePhase == .inactive && isSuspended {
                        // アプリフォアグラウンド時
                        isSuspended = false
                        onResume?()
                    }
                case .inactive, .background:
                    if scenePhase == .active && !isSuspended {
                        // アプリサスペンド時
                        isSuspended = true
                        onSuspend?()
                    }
                default: break
                }
            }
            .onAppear {
                isPresented = true
            }
            .onDisappear {
                // Viewが非表示になったときに処理を実行しない
                isPresented = false
            }
    }
}


class utility {
  // SoundBoxフォルダ
  private static let SANDBOX_DIRECRORY = "private"

  // DEBUG ログ・ファイル出力
  static func writeStringToFile(content: String, fileName: String = "DEBUG_LOG") {
#if DEBUG
    // ドキュメントディレクトリのURLを取得
    let fileManager = FileManager.default
    guard let documentsURL = self.getDocumentDirectory() else {
      print("Could not find the documents directory.")
      return
    }
    
    // 保存するファイルのURLを作成
    let fileURL = documentsURL.appendingPathComponent(fileName)
    
    // コンテンツを追加するためのデータ
    let _content = String("\(content)\n")
    guard let data = _content.data(using: .utf8) else {
      print("Could not convert string to data.")
      return
    }
    
    // ファイルが存在するかチェック
    if fileManager.fileExists(atPath: fileURL.path) {
      // ファイルが存在する場合は追加書き込み
      if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
        fileHandle.seekToEndOfFile()
        fileHandle.write(data)
        fileHandle.closeFile()
        print("Content appended successfully to \(fileURL.path)")
      } else {
        print("Could not open file for writing.")
      }
    } else {
      // ファイルが存在しない場合は新規作成して書き込み
      do {
        try data.write(to: fileURL, options: .atomicWrite)
        print("File created and written successfully to \(fileURL.path)")
      } catch {
        print("Failed to write file: \(error)")
      }
    }
#endif
  }
  
  /// Documentディレクトリ取得
  static func getDocumentDirectory() -> URL?{
    if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      // サンドボックスのフォルダを付加
      if utility.isSoundBox() {
        return URL(fileURLWithPath:String("\(self.SANDBOX_DIRECRORY)\(docDir.path)"))
      } else {
        return docDir
      }
    }
    return nil
  }
  
  /// 環境がサンドボックスか
  static func isSoundBox() -> Bool{
    // Get Temporary Directory
    let tmpDir = NSTemporaryDirectory().split(separator: "/")
    if tmpDir.count > 0 {
      if tmpDir[0] == self.SANDBOX_DIRECRORY {
        return true
      }
    }
    
    return false
  }

}
