//
//  MP3File.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/04/10.
//

import SwiftUI
import AVFoundation

struct MP3File: View {
  @Binding var nextView: SwiftTestViews
  
  @State private var titleTag = ""
  @State private var copyrightsTag = ""
  @State private var artistTag = ""
  @State private var authorTag = ""
  @State private var albumNameTag = ""
  @State private var artworkTagText = ""
  @State private var imageData:Data?
  @State private var albumArtwork: Image?
  
  var body: some View {
    HStack {
      Button("ID3タグ 取得") {
        if let _mp3FileURL = Bundle.main.url(forResource: "01_REPLICANT J.B", withExtension: "m4a") {
          // ID3タグ取得
          if let _id3Tags = extractID3Tags(from: _mp3FileURL) {
            
            self.titleTag = getText(id3Tags: _id3Tags, key: "title")
            
            self.copyrightsTag = getText(id3Tags: _id3Tags, key: "copyrights")
            
            self.artistTag = getText(id3Tags: _id3Tags, key: "artist")
            
            self.authorTag = getText(id3Tags: _id3Tags, key: "author")
            
            self.albumNameTag = getText(id3Tags: _id3Tags, key: "albumName")
            
            if let _artworkTag = _id3Tags.first(where: {$0.key == "artwork"}) {
              self.imageData = _artworkTag.value as? Data
              if let _imageData = self.imageData {
                if let _uiImage = UIImage(data: _imageData) {
                  albumArtwork = Image(uiImage: _uiImage)
                }
              } else {
                self.artworkTagText = "Image Data なし"
              }
            } else {
              self.artworkTagText = "Tag なし"
            }
            
            
          } else {
            print("Failed to extract ID3 tags.")
          }
        } else {
          print("MP3 file not found.")
        }
      }
      Spacer()
      if let _imageData = self.imageData {
        Button("アートワークのファイル保存") {
          // 保存用URL取得
          if let desktopURL = getDocumentDirectory() {
            // 保存ファイル名
            let imageURL = desktopURL.appendingPathComponent("SaveArtwork.png")
            
            print(imageURL.path(percentEncoded: false))
            do {
              try _imageData.write(to: imageURL)
            } catch {
              print(error.localizedDescription)
            }
          }
        }
      }
    }
    .padding([.top, .bottom], 30)

    VStack(alignment: .leading) {
      HStack {
        Text("TitleTag:")
        Text("\(self.titleTag)")
          .foregroundStyle(.blue)
      }
      .padding(.bottom, 20)
      
      HStack {
        Text("CopyrightsTag:")
        Text("\(self.copyrightsTag)")
          .foregroundStyle(.blue)
      }
      .padding(.bottom, 20)
      
      HStack {
        Text("ArtistTag:")
        Text("\(self.artistTag)")
          .foregroundStyle(.blue)
      }
      .padding(.bottom, 20)
      
      HStack {
        Text("AuthorTag:")
        Text("\(authorTag)")
          .foregroundStyle(.blue)
      }
      .padding(.bottom, 20)
      
      HStack {
        Text("AlbumNameTag:")
        Text("\(albumNameTag)")
          .foregroundStyle(.blue)
      }
      .padding(.bottom, 20)
      
      Text("artwork:")
        .padding(.bottom, 20)
      Text("\(artworkTagText)")
        .foregroundStyle(.red)
      
      
      if let artwork = albumArtwork {
        artwork
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200, height: 200)
      } else {
        if let _imageData = self.imageData {
          if let _uiImage = UIImage(data: _imageData) {
            Image(uiImage: _uiImage)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 200, height: 200)
          }
        }
      }
    }
  }
  
  func extractID3Tags(from mp3FileURL: URL) -> [String: Any]? {
    do {
      // AVAssetを使用してMP3ファイルを読み込む
      let asset = AVAsset(url: mp3FileURL)
      
      // AVAssetからID3メタデータを取得
      let metadata = asset.metadata
      
      // ID3メタデータから必要な情報を抽出する
      var id3Tags: [String: Any] = [:]
      for item in metadata {
        print(item.commonKey)
        if let key = item.commonKey?.rawValue, let value = item.value {
          id3Tags[key] = value
        }
      }
      
      return id3Tags
    } catch {
      print("Failed to extract ID3 tags: \(error.localizedDescription)")
      return nil
    }
  }
  func getText(id3Tags: [String : Any], key: String) -> String {
    if let tag = id3Tags.first(where: {$0.key == key}) {
      if let txt = tag.value as? String {
        return txt
      } else {
        return "String以外"
      }
    }
    return "Tag なし"
  }
  /// Documentディレクトリ取得
  func getDocumentDirectory() -> URL?{
    if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      // サンドボックスのフォルダを付加
      if isSoundBox() {
        return URL(fileURLWithPath:String("\"private)\(docDir.path)"))
      } else {
        return docDir
      }
    }
    return nil
  }
  
  /// 環境がサンドボックスか
  func isSoundBox() -> Bool{
    
    // Get Temporary Directory
    let tmpDir = NSTemporaryDirectory().split(separator: "/")
    if tmpDir.count > 0 {
      if tmpDir[0] == "private" {
        return true
      }
    }
    
    return false
  }
}
