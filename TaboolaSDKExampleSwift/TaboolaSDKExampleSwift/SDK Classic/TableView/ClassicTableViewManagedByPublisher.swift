//
//  ClassicTableViewManagedByPublisher.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 13/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicTableViewManagedByPublisherController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        classicPage = TBLClassicPage.init(pageType: "article", pageUrl: "http://www.example.com", delegate: self, scrollView: self.tableView)
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: "Below Article", mode: "alternating-widget-without-video-1x4", placementType: PlacementTypeWidget)
        
        if let taboolaWidgetPlacement = taboolaWidgetPlacement{
            taboolaWidgetPlacement.fetchContent()
        }
        
        taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: "Feed without video", mode: "thumbs-feed-01", placementType: PlacementTypeFeed)

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

extension ClassicTableViewManagedByPublisherController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaboolaTableViewCell", for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaWidgetPlacement = taboolaWidgetPlacement{
                cell.addSubview(taboolaWidgetPlacement)
            }
            return cell
        case Constants.taboolaFeedSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaboolaTableViewCell", for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaFeedPlacement = taboolaFeedPlacement{
                cell.addSubview(taboolaFeedPlacement)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        }
    }
    
    func clearTaboolaInReusedCell(cell :UITableViewCell){
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.totalSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            return taboolaWidgetPlacement?.placementHeight ?? 200
        case Constants.taboolaFeedSection:
            return taboolaFeedPlacement?.placementHeight ?? 200
        default:
            return 200;
        }
    }
}

extension ClassicTableViewManagedByPublisherController: TBLClassicPageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrChangeHeightOfPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.widgetPlacement{
            taboolaWidgetPlacement?.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: taboolaWidgetPlacement?.placementHeight ?? 200)
        }
        else{
            taboolaFeedPlacement?.frame = CGRect(x: taboolaFeedPlacement?.frame.origin.x ?? 0,y: taboolaFeedPlacement?.frame.origin.y ?? 0,width: self.view.frame.size.width,height: taboolaFeedPlacement?.placementHeight ?? 200)
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
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
