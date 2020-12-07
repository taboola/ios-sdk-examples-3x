//
//  ClassicTableViewController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 20/04/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicTableViewManagedByTaboolaController: UIViewController {

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

extension ClassicTableViewManagedByTaboolaController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                let cell = taboolaWidgetPlacement.tableView(tableView, cellForRowAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        case Constants.taboolaFeedSection:
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                let cell = taboolaFeedPlacement.tableView(tableView, cellForRowAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell", for: indexPath)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.totalSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var widgetHeight = CGFloat(200.0)

        if indexPath.section == Constants.taboolaWidgetSection{
            if let taboolaHeight = taboolaWidgetPlacement?.tableView(tableView, heightForRowAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)){
                widgetHeight = taboolaHeight
            }
        }
        if indexPath.section == Constants.taboolaFeedSection{
            if let taboolaHeight = taboolaFeedPlacement?.tableView(tableView, heightForRowAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)){
                widgetHeight = taboolaHeight
            }
        }
        return widgetHeight
    }
}

extension ClassicTableViewManagedByTaboolaController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true;
    }
}

