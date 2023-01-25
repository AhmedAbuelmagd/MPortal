//
//  ProductsTVHeaderCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 19/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH

class ProductsTVHeaderCell: UITableViewHeaderFooterView {
    @IBOutlet weak var biddersLbl: UILabel!
    @IBOutlet weak var showAllLbl: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if MOLHLanguage.isArabic(){
            self.arrowImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        biddersLbl.customLabel(color: .C1D1D1D, size: .size_14, font: .W500, text: LBLs.SIMILAR_PRODUCTS.title)
        showAllLbl.customLabel(color: .CD20653, size: .size_13, font: .W400, text: LBLs.SHOW_ALL.title)
        // Initialization code
    }
}
