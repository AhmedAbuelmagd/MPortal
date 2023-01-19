//
//  ImageSliderCVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 16/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import Kingfisher

class ImageSliderCVCell: UICollectionViewCell {

    @IBOutlet weak var sliderImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension ImageSliderCVCell{
    func initCell(cellData: Ads_banners){
        if let url = URL(string: (cellData.img ?? "")) {
            sliderImg.kf.indicatorType = .activity
            sliderImg.kf.setImage(with: url, placeholder: UIImage(named: ""), options: [.transition(.fade(1))])
                }
        
    }
}
