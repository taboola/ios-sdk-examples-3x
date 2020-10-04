//
//  NativeViewController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 22/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import Foundation
import TaboolaSDK

class NativeViewController: UIViewController {
    
    // TBLNativeItem object that will hold taboola native recommendations
    var taboolaItem: TBLNativeItem?

    // Multiple Taboola objects for Image/Description/Branding/Title
    @IBOutlet weak var imageView: TBLImageView!
    @IBOutlet weak var descriptionLabel: TBLDescriptionLabel!
    @IBOutlet weak var brandingLabel: TBLBrandingLabel!
    @IBOutlet weak var titleLabel: TBLTitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taboolaInit()
    }
    
    func taboolaInit(){
        let nativePage =  TBLNativePage.init(delegate: self, sourceType: SourceTypeText, pageUrl: "http://www.example.com")
        
        let taboolaUnit = nativePage.createUnit(withPlacement: "Below Article", numberOfItems: 1)
                
        taboolaUnit.fetch(onSuccess: {[weak self] (response) in
            if let item = response?.items.firstObject as? TBLNativeItem{
                self?.taboolaItem = item
                self?.updateTaboolaUI()
            }
        }) { (error) in
            print(error.debugDescription)
        }
    }
    
    func updateTaboolaUI() {
        if let item = taboolaItem {
            item.initThumbnailView(imageView)
            item.initDescriptionView(descriptionLabel)
            item.initBrandingView(brandingLabel)
            item.initTitleView(titleLabel)
        }
    }
}

extension NativeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.totalSectionsNative
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.totalRowsNative
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") ?? UITableViewCell(style: .default, reuseIdentifier: "TextCell")
        cell.textLabel?.text = Constants.nativeText
        return cell
    }
}

extension NativeViewController: TBLNativePageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrChangeHeightOfPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print(error as Any)
    }
    
    func onItemClick(_ placementName: String, withItemId itemId: String, withClickUrl clickUrl: String, isOrganic organic: Bool, customData: String) -> Bool {
        true
    }
}
