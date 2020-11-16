//
//  PageView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct PageView: View {
    
    let title: String
    let colors: [Color] = [.red, .green, .yellow, .blue]
    
    var body: some View {
        TabView {
            ForEach(0..<4) { index in
                ScrollViewView(title: title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(colors[index % colors.count])
                                            .cornerRadius(8)
            }
        }.tabViewStyle(PageTabViewStyle())
        .navigationBarTitle(title)
    }
}

@available(iOS 13.0, *)
struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            PageView(title: "PageView")
        } else {
            Text("Available only in ios14. SwiftUI 2")
        }
    }
}
