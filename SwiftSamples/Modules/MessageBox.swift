//
//  MessageBox.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/10.
//

import SwiftUI

struct MessageBox: View {
  @Binding var nextView: SwiftTestViews

  @State private var showAlert1 = false
  @State private var showAlert2 = false
  @State private var showAlert3 = false
  @State private var showAlert4 = false
  @State private var userId = ""
  @State private var passWd = ""
  @State private var showDialog1 = false
  @State private var showDialog2 = false
  @State private var isFavorite = false

  var body: some View {
    List {
      Section {
        HStack {
          Button("Alert 1") { self.showAlert1.toggle() }
            .alert(isPresented: self.$showAlert1) {
              Alert(
                title: Text("Alert1"),
                message: Text("XXXXXXXXXXX？"),
                primaryButton: .default(Text("OK")) { print("OK") },
                secondaryButton: .cancel() { print("Cancel") }
              )
            }
          Text("(iOS 13.0–17.4")
          Text("Deprecated")
            .foregroundStyle(.orange)
            .bold()
          Text(")")
        }
        Button("Alert 2") { self.showAlert2.toggle() }
        .alert("Alert3", isPresented: self.$showAlert2) {
          Button("Cancel"){ print("Cancel") }
          Button("OK"){ print("OK") }
        }
        HStack {
          Button("Alert 3") { self.showAlert3.toggle() }
            .alert("Alert3", isPresented: self.$showAlert3) {
              Button("Yes"){ print("Yes") }
              Button("NO"){ print("NO") }
              Button("Cancel"){ print("Cancel") }
            }
          Text("(３つ以上のボタン)")
        }
        HStack {
          Button("Alert 4") { self.showAlert4.toggle() }
            .alert("Alert4", isPresented: self.$showAlert4) {
              TextField("User ID", text: $userId)
//              SecureField("Password", text: $passWd)
              Button("Cancel"){ print("Cancel") }
              Button("OK"){ print("OK UserId:\(self.userId) Password:\(self.passWd)") }
            }
          Text("(入力フィールド)")
        }

      } header: {
        Text("Alert")
          .headerProminence(.increased)
      }
      Section {
        HStack {
          Button("Dialog1") {
            self.showDialog1.toggle()
          }
          .confirmationDialog("タイトル１", isPresented: $showDialog1, titleVisibility: .visible) {
            Button("Item1") {
              print("Item1")
            }
            Button("Item2") {
              print("Item2")
            }
            Button("Item3") {
              print("Item3")
            }
          } message: {
            Text("メッセージ")
          }
          Text("(Title あり)")
        }
        HStack {
          Button("Dialog2") {
            self.showDialog2.toggle()
          }
          .confirmationDialog("タイトル２", isPresented: $showDialog2, titleVisibility: .hidden) {
            Button("Item1") {
              print("Item1")
            }
            Button("Item2") {
              print("Item2")
            }
            Button("Item3") {
              print("Item3")
            }
          } message: {
            Text("メッセージ")
          }
          Text("(Title なし)")
        }
      } header: {
        Text("Dialog")
          .headerProminence(.increased)
      }
    }
    // 戻るボタン
    Spacer()
    Button("Return"){
      nextView = .topView
    }
  }
}
