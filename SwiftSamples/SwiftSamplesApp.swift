//
//  SwiftSamplesApp.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/03/20.
//

import SwiftUI

@main
struct SwiftSamplesApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView2()
//      TestEtcView()
    }
  }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // アプリの起動時の初期化などを行う
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // アプリが終了する直前に呼ばれる
        print("アプリが終了する直前")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // アプリがバックグラウンドに移行する直前に呼ばれる
        print("アプリがバックグラウンドに移行する直前")
    }
}
