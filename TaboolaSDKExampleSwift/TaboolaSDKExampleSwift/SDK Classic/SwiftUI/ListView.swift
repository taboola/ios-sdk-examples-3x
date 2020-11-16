//
//  ListView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ListView: View {
//    let taboolaWidgets: [TBLClassicUnitSwiftUI]
    
    let title: String
    let pageSwift = TBLClassicPageSwift(pageType: "article", pageUrl: "http://www.example.com")
    let mode: String = "alternating-widget-without-video-1x4"
    let topPlacement: String = "Top"
    let feedPlacement: String = "Feed without video"
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0
    
//    public init(title:String) {
//        self.title = title
//        self.pageSwift = TBLClassicPageSwift(pageType: "article", pageUrl: "http://www.example.com")
//        self.taboolaWidgets = [TBLClassicUnitSwiftUI(page: self.pageSwift, placement: topPlacement, mode: mode, height: topHeight),
//                               TBLClassicUnitSwiftUI(page: self.pageSwift, placement: feedPlacement, mode: mode, height: feedHeight)]
//    }
    
//    var body: some View {
//        List {
//            ForEach(0..<4) { index in
//                self.buildView(index: index)
//            }
//        }
//    }
//
//    func buildView(index: Int) -> AnyView {
//        switch index {
//        case 0:
//            return AnyView( LoremText())
//        case 1:
//            return AnyView (taboolaWidgets[0])
//        case 2:
//            return AnyView( LoremText())
//        case 3:
//            return AnyView (taboolaWidgets[1])
//        default:
//            return AnyView(EmptyView())
//        }
//
//    }
    
    
    var body: some View {
        List {
            LoremText()
            TBLClassicUnitSwiftUI(page: self.pageSwift, placement: topPlacement, mode: mode, height: $topHeight).frame(height: topHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            LoremText()
            TBLClassicUnitSwiftUI(page: self.pageSwift, placement: feedPlacement, mode: mode, height: $feedHeight).frame(height: feedHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.navigationBarTitle(title)
    }
}

@available(iOS 13.0, *)
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "ListView")
    }
}
