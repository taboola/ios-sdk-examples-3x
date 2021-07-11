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

    @IBOutlet weak var collectionView: UICollectionView!
    var nativePage: TBLNativePage?
    var taboolaUnit: TBLNativeUnit?
    var itemsArray: NSMutableArray? // itemsArray object that will hold taboola native recommendations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsArray = NSMutableArray()
        self.collectionView.register(UINib(nibName: "NativeViewControllerCell", bundle: nil), forCellWithReuseIdentifier: "NativeViewControllerCell")
        taboolaInit()
    }
    
    func taboolaInit() {
        nativePage =  TBLNativePage.init(delegate: self, sourceType: SourceTypeText, pageUrl: "http://blog.taboola.com")
        taboolaUnit = nativePage?.createUnit(withPlacement: "Below Article", numberOfItems: 1)
                
        taboolaUnit?.fetchContent(onSuccess: {[weak self] (response) in
            self?.itemsArray = response?.items
            self?.collectionView.reloadData()
        }) { (error) in
            print(error.debugDescription)
        }
    }
    
    func fetchNextPage() {
        taboolaUnit?.fetchContent(onSuccess: { (response) in
            if let response = response {
                guard let newItems = response.items else { return }
                self.collectionView.performBatchUpdates({
                    guard let resultsSize = self.itemsArray?.count else { return }
                    self.itemsArray?.add(newItems)
                    let arrayWithIndexPaths = NSMutableArray()
                    for i in 0...(resultsSize + newItems.count) {
                        arrayWithIndexPaths.add(NSIndexPath(row: i, section: 0))
                    }
                    self.collectionView.insertItems(at: arrayWithIndexPaths as! [IndexPath])
                }, completion: nil)
            }
        }, onFailure: { (error) in
            
        })
    }
}

extension NativeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.totalSectionsNative
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsArray = itemsArray else { return 0 }
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NativeCollectionViewCell", for: indexPath)
        if let cell = cell as? NativeViewControllerCell {
            cell.attributionButton.addTarget(self, action: #selector(clickedTaboolaAttribution), for: .touchDown)
            guard let itemsArray = itemsArray else { return cell }
            if let item = itemsArray[indexPath.row] as? TBLNativeItem {
                if let imageUrl = item.extraDataDictionary()["imageUrl"] as? NSString {
                    DispatchQueue.global(qos: .background).async {
                        guard let data = NSData.init(contentsOf: NSURL(string: imageUrl as String)! as URL) else { return }
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: data as Data)
                        }
                    }
                    cell.imageView.isHidden = false
                    cell.tbImageView.isHidden = true
                    cell.tbImageView.isUserInteractionEnabled = false
                    cell.imageView.isUserInteractionEnabled = true
                } else {
                    item.initThumbnailView(cell.tbImageView)
                    cell.imageView.isHidden = true
                    cell.tbImageView.isHidden = false
                    cell.tbImageView.isUserInteractionEnabled = true
                    cell.imageView.isUserInteractionEnabled = false
                }
                
                item.initTitleView(cell.titleLabel)
                item.initBrandingView(cell.brandingLabel)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let itemsArray = itemsArray else { return }
        if indexPath.row == itemsArray.count - 1 {
            self.fetchNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemsArray = itemsArray else { return }
        if let item = itemsArray[indexPath.row] as? TBLNativeItem {
            item.handleClickEvent()
        }
    }
    
    @objc func clickedTaboolaAttribution() {
        nativePage?.handleAttributionClick()
    }
}

extension NativeViewController: TBLNativePageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrResizePlacement placementName: String!, withHeight height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print(error as Any)
    }
    
    func onItemClick(_ placementName: String, withItemId itemId: String, withClickUrl clickUrl: String, isOrganic organic: Bool, customData: String) -> Bool {
        true
    }
}
