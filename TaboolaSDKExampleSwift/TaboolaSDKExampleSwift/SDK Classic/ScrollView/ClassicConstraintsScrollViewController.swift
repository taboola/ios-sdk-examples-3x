//
//  ClassicConstraintsScrollViewController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 22/04/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicConstraintsScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topWidget: UIView!
    @IBOutlet weak var bottomFeed: UIView!

    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taboolaInit()
    }
    
    func taboolaInit(){
        classicPage = TBLClassicPage.init(pageType: "article", pageUrl: "http://www.example.com", delegate: self, scrollView: scrollView)
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: "Above Article", mode: "alternating-widget-without-video-1x1", placementType: PlacementTypeWidget)
        
        taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: "Feed without video", mode: "thumbs-feed-01", placementType: PlacementTypeFeed)

        if let taboolaWidgetPlacement = taboolaWidgetPlacement{
            taboolaWidgetPlacement.fetchContent()
        }
        
        if let taboolaFeedPlacement = taboolaFeedPlacement{
            taboolaFeedPlacement.clipsToBounds = true
            taboolaFeedPlacement.fetchContent()
        }
        
        setTaboolaConstraintsToSuper()
    }
    
    func setTaboolaConstraintsToSuper() {
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            topWidget.addSubview(taboolaWidgetPlacement)
            taboolaWidgetPlacement.translatesAutoresizingMaskIntoConstraints = false
            taboolaWidgetPlacement.topAnchor.constraint(equalTo: topWidget.topAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.bottomAnchor.constraint(equalTo: topWidget.bottomAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.leadingAnchor.constraint(equalTo: topWidget.leadingAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.trailingAnchor.constraint(equalTo: topWidget.trailingAnchor, constant: 0).isActive = true
        }
        
        if let taboolaFeedPlacement = taboolaFeedPlacement {
            bottomFeed.addSubview(taboolaFeedPlacement)
            taboolaFeedPlacement.translatesAutoresizingMaskIntoConstraints = false
            taboolaFeedPlacement.topAnchor.constraint(equalTo: bottomFeed.topAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.bottomAnchor.constraint(equalTo: bottomFeed.bottomAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.leadingAnchor.constraint(equalTo: bottomFeed.leadingAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.trailingAnchor.constraint(equalTo: bottomFeed.trailingAnchor, constant: 0).isActive = true
        }
    }
    
    deinit{
        if let taboolaWidgetPlacement = taboolaWidgetPlacement{
            taboolaWidgetPlacement.reset()
        }
        if let taboolaFeedPlacement = taboolaFeedPlacement{
            taboolaFeedPlacement.reset()
        }
    }
}

extension ClassicConstraintsScrollViewController: TBLClassicPageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrChangeHeightOfPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print(error as Any)
    }
    
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        if (!organic) {
            return false;
        }
        return true;
    }
}
