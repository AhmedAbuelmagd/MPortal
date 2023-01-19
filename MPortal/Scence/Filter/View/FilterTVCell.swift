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
    
}

extension FilterTVCell{
    func initCell(cellData: Categories){
        namageData(isSelected: cellData.isSelected ?? false, title: cellData.name ?? "")
    }
    func initCell(cellData: Children){
        namageData(isSelected: cellData.isSelected ?? false, title: cellData.name ?? "")
    }
    func initCell(cellData: Options){
        namageData(isSelected: cellData.isSelected ?? false, title: cellData.name ?? "")
    }
    func namageData(isSelected: Bool, title: String){
        checkImg.image = isSelected ? Images.CHECK.image : Images.NONE.image
        nameLbl.customLabel(color: isSelected ? .CF45B14:.C515D76, size: .size_13, font: .W400, text: title.lowercased())
    }
}
