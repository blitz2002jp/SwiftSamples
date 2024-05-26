//
//  EarphoneControlView.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/05/04.
//

import SwiftUI
import AVFoundation
import MediaPlayer

// イアホンからのコントロール
struct EarphoneControlView: View {
  @Binding var nextView: SwiftTestViews
  
  var body: some View {
    let a = EarphoneControl()
  }

}

class aaa {
  init() {
  }
}

class EarphoneControl: NSObject, AVAudioPlayerDelegate {

  override init() {
    super.init()
    
    self.addRemoteCommandEvent()
  }
  
  func play() {
    
  }
  
  // 外部アクセサリ(イヤホンなど)、システムコントロールのイベントへの応答定義
  func addRemoteCommandEvent() {
    let commandCenter = MPRemoteCommandCenter.shared()
    commandCenter.togglePlayPauseCommand.addTarget(handler: { [unowned self] commandEvent -> MPRemoteCommandHandlerStatus in
      self.remoteTogglePlayPause(commandEvent)
      return MPRemoteCommandHandlerStatus.success
    })
    commandCenter.playCommand.addTarget(handler: { [unowned self] commandEvent -> MPRemoteCommandHandlerStatus in
      self.remotePlay(commandEvent)
      return MPRemoteCommandHandlerStatus.success
    })
    commandCenter.pauseCommand.addTarget(handler: { [unowned self] commandEvent -> MPRemoteCommandHandlerStatus in
      self.remotePause(commandEvent)
      return MPRemoteCommandHandlerStatus.success
    })
    commandCenter.nextTrackCommand.addTarget(handler: { [unowned self] commandEvent -> MPRemoteCommandHandlerStatus in
      self.remoteNextTrack(commandEvent)
      return MPRemoteCommandHandlerStatus.success
    })
    commandCenter.previousTrackCommand.addTarget(handler: { [unowned self] commandEvent -> MPRemoteCommandHandlerStatus in
      self.remotePrevTrack(commandEvent)
      return MPRemoteCommandHandlerStatus.success
    })
  }

  // イヤホンのセンターボタンを押した時の処理
  func remoteTogglePlayPause(_ event: MPRemoteCommandEvent) {
    print("イヤホンのセンターボタンを押した時の処理")
    // （今回は再生中なら停止、停止中なら再生をおこなっています）
  }
  
  func remotePlay(_ event: MPRemoteCommandEvent) {
    // プレイボタンが押された時の処理
    print("プレイボタンが押された時の処理")
    // （今回は再生をおこなっています）
  }
  
  func remotePause(_ event: MPRemoteCommandEvent) {
    // ポーズボタンが押された時の処理
    print("ポーズが押された時の処理")
    // （今回は停止をおこなっています）
  }
  
  func remoteNextTrack(_ event: MPRemoteCommandEvent) {
    // 「次へ」ボタンが押された時の処理
    // （略）
  }
  
  func remotePrevTrack(_ event: MPRemoteCommandEvent) {
    // 「前へ」ボタンが押された時の処理
    // （略）
  }
}
