//
//  ProductCVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 19/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class ProductCVCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder(borderColor: .CD9D9D9, borderWidth: 1)
        mainView.addRadius(radius: 7)
        imageContainerView.addRadius(radius: 7)
        favBtn.circleCornerRadius()
        // Initialization code
    }

}
