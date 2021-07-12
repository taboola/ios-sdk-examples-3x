//
//  NativeViewControllerCell.swift
//  TaboolaSDKExampleSwift
//
//  Created by Karen Shaham Palman on 11/07/2021.
//  Copyright © 2021 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class NativeViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var tbImageView: TBLImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: TBLDescriptionLabel!
    @IBOutlet weak var brandingLabel: TBLBrandingLabel!
    @IBOutlet weak var titleLabel: TBLTitleLabel!
    @IBOutlet weak var attributionButton: UIButton!

    override func prepareForReuse() { // call this in order to have a "fresh start" on each cell
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = ""
        brandingLabel.text = ""
        titleLabel.text = ""
    }
}
