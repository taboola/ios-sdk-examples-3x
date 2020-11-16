//
//  LazyVGridView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LazyVGridView: View {

    let colors: [Color] = [.red, .green, .yellow, .blue]
    var columns: [GridItem] =
           Array(repeating: .init(.flexible(), alignment: .center), count: 1)
    let title: String
    let pageSwift = TBLClassicPageSwift(pageType: "article", pageUrl: "http://www.example.com")
    let mode: String = "alternating-widget-without-video-1x4"
    let topPlacement: String = "Top"
    let feedPlacement: String = "Feed without video"
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0...3, id: \.self) { index in
                    if index%2 == 0 {
                        Text("Cell \(index)")
                            .frame(width: 110, height: 200)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    } else if index == 3 {
                        TBLClassicUnitSwiftUI(page: self.pageSwift, placement: topPlacement, mode: mode, height: $topHeight).frame(height:topHeight)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    } else {
                        TBLClassicUnitSwiftUI(page: self.pageSwift, placement: feedPlacement, mode: mode, height: $feedHeight).frame(height:feedHeight)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    }
                    
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct LazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LazyVGridView(title: "LazyVGridView")
        } else {
            Text("Available only in ios14. SwiftUI 2")
        }
    }
}

