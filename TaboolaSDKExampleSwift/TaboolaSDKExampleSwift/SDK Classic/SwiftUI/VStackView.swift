//
//  VStackView.swift
//  QAApp
//
//  Created by Tzufit Lifshitz on 08/11/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct VStackView: View {
    
    let title: String
    let pageSwift = TBLClassicPageSwift(pageType: "article", pageUrl: "http://www.example.com")
    let mode: String = "alternating-widget-without-video-1x4"
    let topPlacement: String = "Top"
    let feedPlacement: String = "Feed without video"
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                LoremText()
                TBLClassicUnitSwiftUI(page: self.pageSwift, placement: topPlacement, mode: mode, height: $topHeight).frame(height: topHeight)
                LoremText()
                TBLClassicUnitSwiftUI(page: self.pageSwift, placement: feedPlacement, mode: mode, height: $feedHeight).frame(height: feedHeight)
            }
        }.navigationBarTitle(title)
    }
}

@available(iOS 13.0, *)
struct VStackView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LazyVStackView(title: "LazyVStackView")
        } else {
            Text("Available only in ios14. SwiftUI 2")
        }
    }
}
