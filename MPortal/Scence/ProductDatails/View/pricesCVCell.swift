//
//  pricesCVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 16/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class pricesCVCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addRadius(radius: 6)
        // Initialization code
    }

}
