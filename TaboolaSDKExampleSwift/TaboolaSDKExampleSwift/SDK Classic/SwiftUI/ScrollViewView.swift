//
//  ScrollViewView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ScrollViewView: View {
    
    let title: String
    let pageSwift = TBLClassicPageSwift(pageType: "article", pageUrl: "http://www.example.com")
    let mode: String = "alternating-widget-without-video-1x4"
    let topPlacement: String = "Top"
    let feedPlacement: String = "Feed without video"
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            LoremText()
            TBLClassicUnitSwiftUI(page: self.pageSwift, placement: topPlacement, mode: mode, height: $topHeight).frame(height: topHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            LoremText()
            TBLClassicUnitSwiftUI(page: self.pageSwift, placement: feedPlacement, mode: mode, height: $feedHeight).frame(height: feedHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.navigationBarTitle(title)
    }
    
}

@available(iOS 13.0, *)
struct ScrollViewView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewView(title: "ScrollView")
    }
}
