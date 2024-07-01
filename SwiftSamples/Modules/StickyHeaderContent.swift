//
//  StickyHeaderContent.swift
//  SwiftSamples
//
//  Created by masazumi oeda on 2024/06/20.
//

import SwiftUI

struct StickyHeaderView: View {
  var body: some View {
    GeometryReader { proxy in
      ScrollView {
        VStack {
          StickyHeader(proxy: proxy, defaultHeight: 200, minHeight: 50) { bounds in
            StickyHeaderContent(bounds: bounds) // 上で作ったHeader
          }
          ForEach(0..<100) {
            Text($0.description)
              .frame(maxWidth: .infinity)
              .frame(height: 50)
              .background(.black.opacity(0.1))
          }
        }
      }
    }
  }
}

struct StickyHeaderContent: View {
    /// ScrollViewに対する自身のbounds
    var bounds: CGRect
    @Namespace private var ns
    
    var body: some View {
        let isMinimum = bounds.maxY < 50
        let pullDownOffsetY = max(0, bounds.minY)
        ZStack {
            if isMinimum {
                minimumContent
            } else {
                standardContent
            }
        }
        .animation(.default, value: isMinimum)
        .frame(height: bounds.height + pullDownOffsetY)
        .frame(maxWidth: .infinity)
        .background(isMinimum ? .red : .blue)
        .offset(y: isMinimum ? 0 : -(pullDownOffsetY / 2))
    }
    
    private var minimumContent: some View {
        VStack {
            Spacer()
            HStack {
                Circle()
                    .fill(.black.opacity(0.2))
                    .matchedGeometryEffect(id: "circle", in: ns)
                    .frame(width: 30, height: 30)
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .matchedGeometryEffect(id: "rectangle", in: ns)
                    .frame(width: 200, height: 30)
                Spacer()
            }
            .frame(height: 50)
            .padding(.horizontal)
        }
    }
    
    private var standardContent: some View {
        VStack {
            Circle()
                .fill(.black.opacity(0.2))
                .matchedGeometryEffect(id: "circle", in: ns)
                .frame(width: 100, height: 100)
            Rectangle()
                .fill(.black.opacity(0.2))
                .matchedGeometryEffect(id: "rectangle", in: ns)
                .frame(width: 200, height: 30)
        }
        .padding()
    }
}

struct StickyHeader<Content: View>: View {
    /// 親Viewのproxy（全画面を想定）
    var proxy: GeometryProxy
    /// 通常のHeaderの高さ
    var defaultHeight: CGFloat
    /// 最小のHeaderの高さ
    var minHeight: CGFloat
    /// 表示するHeader
    var content: ((CGRect) -> Content)
    
    var body: some View {
        Color.clear
            .frame(height: defaultHeight)
            .frame(maxWidth: .infinity)
            .anchorPreference(key: StickyHeaderPreferenceKey.self, value: .bounds, transform: { $0 })
            .overlayPreferenceValue(StickyHeaderPreferenceKey.self) { value in
                if let value {
                    let bounds = proxy[value]
                    content(bounds)
                        .frame(height: bounds.height)
                        .offset(y: bounds.maxY < minHeight ? minHeight - bounds.maxY : 0)
                }
            }
            .zIndex(1)
    }
}

struct StickyHeaderPreferenceKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}
