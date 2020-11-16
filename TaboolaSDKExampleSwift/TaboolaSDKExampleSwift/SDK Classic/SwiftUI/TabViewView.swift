//
//  TabViewView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct TabViewView: View {
    let title: String
    var body: some View {
        TabView {
            ForEach(0..<3) { index in
                ListView(title: "\(index)")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("\(index)")
                }

            }
        }.navigationBarTitle(title)
    }
}

@available(iOS 13.0, *)
struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView(title: "TabView")
    }
}
