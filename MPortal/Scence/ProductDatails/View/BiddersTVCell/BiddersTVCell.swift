//
//  BiddersTVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 19/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class BiddersTVCell: UITableViewCell {

    @IBOutlet weak var bidderNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bidderNameLbl.customLabel(color: .C44215D, size: .size_14, font: .W400, text: "إسم المزايد")
        timeLbl.customLabel(color: .C808080, size: .size_12, font: .W300, text: "13:59:00")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
