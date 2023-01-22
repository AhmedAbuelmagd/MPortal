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
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var startPriceTitleLbl: UILabel!
    @IBOutlet weak var startPriceValueLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var startAfterTitleLbl: UILabel!
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var minuteLbl: UILabel!
    
    @IBOutlet weak var counterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startAfterTitleLbl.customLabel(color: .C808080, size: .size_10, font: .W300, text: "يبدأ بعد", direction: .Center)
        counterLbl.customLabel(color: .C1D1D1D, size: .size_15, font: .W500, text: "3 :22:55", direction: .Center)
        dayLbl.customLabel(color: .C1D1D1D, size: .size_08, font: .W300, text: "يوم", direction: .Center)
        hourLbl.customLabel(color: .C1D1D1D, size: .size_08, font: .W300, text: "س", direction: .Center)
        minuteLbl.customLabel(color: .C1D1D1D, size: .size_08, font: .W300, text: "د", direction: .Center)
        startPriceTitleLbl.customLabel(color: .C808080, size: .size_10, font: .W300, text: "بداية المزاد", direction: .Center)
        startPriceValueLbl.customLabel(color: .CF45B14, size: .size_15, font: .W500, text: "2000", direction: .Center)
        currencyLbl.customLabel(color: .CF45B14, size: .size_08, font: .W300, text: "ريال",direction: .Center)
        
        typeLbl.customLabel(color: .CFFFFFF, size: .size_10, font: .W500, text: "مزاد مباشر")
        
        descriptionLbl.customLabel(color: .C1D1D1D, size: .size_12, font: .W400, text: "سيارة سريعة بى ام دابليو تصنيع  2021 حالته جديدة")
        mainView.addBorder(borderColor: .CD9D9D9, borderWidth: 1)
        mainView.addRadius(radius: 7)
        imageContainerView.addRadius(radius: 7)
        favBtn.circleCornerRadius()
        // Initialization code
    }

}
