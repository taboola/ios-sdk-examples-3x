//
//  ClassicVStackWithExploreMore.swift
//  ios-sdk-swift-ui-examples-3x
//
//  Created by Sasa Jovanovic on 30. 9. 2025..
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct ClassicVStackWithExploreMore: View {

    let title: String
    let pageWrapper = ClassicPageWrapper(pageType: Constants.article,
                                         pageUrl: Constants.pageUrl)
    
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                LoremText()
                ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                                   placement: Constants.widgetPlacement,
                                   mode: Constants.mode,
                                   height: $topHeight).frame(height: topHeight)
                LoremText()
                ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                                   placement:  Constants.feedPlacement,
                                   mode: Constants.feedMode,
                                   height: $feedHeight).frame(height: feedHeight)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .toolbar {
            ToolbarItem {
                Button {
                    pageWrapper.showExploreMore()
                } label: {
                    Text("Explore More")
                }
            }
        }
        .onAppear(){
            pageWrapper.initExploreMore()
        }
    }
}

struct VStackWithExploreMore_Previews: PreviewProvider {
    static var previews: some View {
        ClassicVStackWithExploreMore(title: "VStack+EM")
    }
}
