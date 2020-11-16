//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SwiftUIViews: View {
    var body: some View {
        VStack(spacing: 20.0) {
            NavigationLink(destination: ScrollViewView(title: "ScrollView")) {
                Text("ScrollView")
            }
            NavigationLink(destination: ListView(title: "ListView")) {
                Text("ListView")
            }
            NavigationLink(destination: TabViewView(title: "TabView")) {
                Text("TabView")
            }
            NavigationLink(destination: VStackView(title: "VStackView")) {
                Text("VStackView")
            }
            if #available(iOS 14.0, *) {
                Text(
                    "iOS 14 SwiftUI 2:"
                ).font(.title)
                NavigationLink(destination: PageView(title: "PageView")) {
                    Text("PageView")
                }
                NavigationLink(destination: LazyVStackView(title: "LazyVStackView")) {
                    Text("LazyVStackView")
                }
                NavigationLink(destination: LazyVGridView(title: "LazyVGridView")) {
                    Text("LazyVGridView")
                }
            }
        }.navigationBarTitle("SwiftUI Example")
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViews()
    }
}
