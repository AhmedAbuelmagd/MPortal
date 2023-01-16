//
//  FilterTVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class FilterTVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FilterTVCell{
    func initCell(cellData: Categories){
        if cellData.isSelected ?? false{
            checkImg.image = UIImage(named: "check>24#MainColor")
        }else{
            checkImg.image = UIImage(named: "")
        }
        nameLbl.customLabel(color: .C515D76, size: .size_01, font: .W300, text: (cellData.name ?? "").lowercased())
    }
    func initCell(cellData: Children){
        if cellData.isSelected ?? false{
            checkImg.image = UIImage(named: "check>24#MainColor")
        }else{
            checkImg.image = UIImage(named: "")
        }
        nameLbl.customLabel(color: .C515D76, size: .size_01, font: .W300, text: (cellData.name ?? "").lowercased())
    }
    func initCell(cellData: Options){
        if cellData.isSelected ?? false{
            checkImg.image = UIImage(named: "check>24#MainColor")
        }else{
            checkImg.image = UIImage(named: "")
        }
        nameLbl.customLabel(color: .C515D76, size: .size_01, font: .W300, text: (cellData.name ?? "").lowercased())
    }
}
