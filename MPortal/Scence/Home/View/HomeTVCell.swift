//
//  HomeTVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

protocol HomeTVCellDeleget: NSObjectProtocol {
    func homeTVCellBtnClicked(index: Int, section: Int, isDate: Bool)
}

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var txtFiels: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var chooseCategoriesBtn: UIButton!
    
    weak var delegte: HomeTVCellDeleget?
    private var index = 0
    private var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder()
        mainView.addRadius(radius: 5)
        
        // Initialization code
    }
    
    @IBAction func chooseCategoriesBtnClicked(_ sender: UIButton) {
        delegte?.homeTVCellBtnClicked(index: index, section: section, isDate: false)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initCell(cellData: Filter, index: Int, section: Int){
        txtFiels.text = ""
        self.section = section
        self.index = index
        titleLbl.customLabel(color: .C515D76, size: .size_09, font: .W300, text: cellData.title ?? "")
        txtFiels.customTxtField(color: .C515D76, size: .size_14, font: .W400, placeholder: "\((cellData.placeholder ?? "").lowercased())", text: (cellData.name ?? "").lowercased(), isPassword: false)
    }
    func initCell(cellData: PropertiesModel, index: Int, section: Int){
        txtFiels.text = ""
        self.section = section
        self.index = index
        if cellData.options?.count == 0{
            chooseCategoriesBtn.isHidden = true
            arrowImg.isHidden = true
        }
        titleLbl.customLabel(color: .C515D76, size: .size_09, font: .W300, text: cellData.name ?? "")
        txtFiels.customTxtField(color: .C515D76, size: .size_14, font: .W400, placeholder: "Select \(cellData.name ?? "")", text: "", isPassword: false)
    }
    
}
