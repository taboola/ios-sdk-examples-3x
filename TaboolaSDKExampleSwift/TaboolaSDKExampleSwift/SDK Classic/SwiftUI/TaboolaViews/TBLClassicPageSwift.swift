//
//  TBLClassicPageSwift.swift
//  QAApp
//
//  Created by Tzufit Lifshitz on 14/09/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//
import TaboolaSDK

protocol TBLClassicPageSwiftDelegate {
    func didLoadWithHeight(height: CGFloat)
}

@available(iOS 13.0, *)
class TBLClassicPageSwift : NSObject, TBLClassicPageDelegate {
    
    var pageDelegates = [TBLClassicPageSwiftDelegate]()
    var page : TBLClassicPage!
    
    init(pageType: String, pageUrl: String) {
        super.init()
        //TODO change scrollView to nil after SDK update
        let page = TBLClassicPage(pageType: pageType, pageUrl: pageUrl, delegate: self, scrollView: UIScrollView())
        page.pageExtraProperties = ["disableScrollIntercept":NSNumber(value:true)]
        self.page = page
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadOrResizePlacement placementName: String!, withHeight height: CGFloat, placementType: PlacementType) {
        for pageDelegate in pageDelegates {
            if let delegate = pageDelegate as? Coordinator {
                if placementName.contains(delegate.parent.placement) {
                    delegate.didLoadWithHeight(height: height)
                }
            }
        }
    }

}
