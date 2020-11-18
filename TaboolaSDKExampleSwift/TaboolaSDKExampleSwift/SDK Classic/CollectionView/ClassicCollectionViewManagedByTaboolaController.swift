//
//  ClassicCollectionViewManagedByTaboolaController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 22/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicCollectionViewManagedByTaboolaController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        classicPage = TBLClassicPage.init(pageType: "article", pageUrl: "http://www.example.com", delegate: self, scrollView: self.collectionView)
        classicPage?.pageExtraProperties = ["key":"true"]
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: "Below Article", mode: "alternating-widget-without-video-1x4")
        
        if let taboolaWidgetPlacement = taboolaWidgetPlacement{
            taboolaWidgetPlacement.fetchContent()
        }
        
        taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: "Feed without video", mode: "thumbs-feed-01")

        if let taboolaFeedPlacement = taboolaFeedPlacement{
            taboolaFeedPlacement.fetchContent()
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

extension ClassicCollectionViewManagedByTaboolaController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                let cell = taboolaWidgetPlacement.collectionView(collectionView, cellForItemAt: indexPath, withBackground: UIColor.red)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        case Constants.taboolaFeedSection:
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                let cell = taboolaFeedPlacement.collectionView(collectionView, cellForItemAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        }
    }
    
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.totalSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widgetSize = CGSize(width: self.view.frame.size.width, height: 200)

        if indexPath.section == Constants.taboolaWidgetSection{
            if let taboolaSize = taboolaWidgetPlacement?.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)){
                    widgetSize = taboolaSize
            }
        }
        
        if indexPath.section == Constants.taboolaFeedSection{
            if let taboolaSize = taboolaFeedPlacement?.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)){
                    widgetSize = taboolaSize
                }
        }
        return widgetSize
    }
}

extension ClassicCollectionViewManagedByTaboolaController: TBLClassicPageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrResizePlacement placementName: String!, withHeight height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print(error as Any)
    }
    
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return false;
    }
}
