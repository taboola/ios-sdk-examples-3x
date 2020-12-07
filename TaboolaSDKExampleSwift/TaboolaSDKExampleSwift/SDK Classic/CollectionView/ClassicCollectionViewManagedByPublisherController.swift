//
//  ClassicCollectionViewManagedByPublisherController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 11/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicCollectionViewManagedByPublisherController: UIViewController {
    
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

extension ClassicCollectionViewManagedByPublisherController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaboolaCollectionViewCell", for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaWidgetPlacement = taboolaWidgetPlacement{
                cell.addSubview(taboolaWidgetPlacement)
            }
            return cell
        case Constants.taboolaFeedSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaboolaCollectionViewCell", for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaFeedPlacement = taboolaFeedPlacement{
                cell.addSubview(taboolaFeedPlacement)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        }
    }
    
    func clearTaboolaInReusedCell(cell :UICollectionViewCell){
        for view in cell.subviews{
            view.removeFromSuperview()
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
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            return CGSize(width: self.view.frame.size.width, height: taboolaWidgetPlacement?.placementHeight ?? 200)
        case Constants.taboolaFeedSection:
            return CGSize(width: self.view.frame.size.width, height: taboolaFeedPlacement?.placementHeight ?? 200)
        default:
            return CGSize(width: self.view.frame.size.width, height: 200);
        }
    }
}

extension ClassicCollectionViewManagedByPublisherController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.widgetPlacement{
            taboolaWidgetPlacement?.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: taboolaWidgetPlacement?.placementHeight ?? 200)
        }
        else{
            taboolaFeedPlacement?.frame = CGRect(x: taboolaFeedPlacement?.frame.origin.x ?? 0,y: taboolaFeedPlacement?.frame.origin.y ?? 0,width: self.view.frame.size.width,height: taboolaFeedPlacement?.placementHeight ?? 200)
        }
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true;
    }
}
