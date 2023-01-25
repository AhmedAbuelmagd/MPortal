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
    @IBOutlet weak var othersView: UIView!
    @IBOutlet weak var otherMainView: UIView!
    
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var chooseCategoriesBtn: UIButton!
    
    @IBOutlet weak var otherLbl: UILabel!
    @IBOutlet weak var otherTxtField: UITextField!
    
    
    weak var delegte: HomeTVCellDeleget?
    private var index = 0
    private var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for view in [mainView, otherMainView]{
            view?.addBorder()
            view?.addRadius(radius: 5)
            otherLbl.customLabel(color: .C515D76, size: .size_13, font: .W400, text: LBLs.OTHER.title)
            otherTxtField.customTxtField(color: .C515D76, size: .size_13, font: .W400, placeholder: "\(LBLs.SELECT.title)\(LBLs.OTHER.title)", text: "")
        }
    }
    
    @IBAction func chooseCategoriesBtnClicked(_ sender: UIButton) {
        delegte?.homeTVCellBtnClicked(index: index, section: section, isDate: false)
    }

    func initCell(cellData: Filter, index: Int, section: Int){
        chooseCategoriesBtn.isHidden = false
        txtFiels.text = ""
        self.section = section
        self.index = index
        titleLbl.customLabel(color: .C515D76, size: .size_13, font: .W400, text: (cellData.title ?? "").localized)
        txtFiels.customTxtField(color: .C515D76, size: .size_13, font: .W400, placeholder: "\((cellData.placeholder ?? "").localized)", text: (cellData.name ?? "").lowercased(), isPassword: false)
    }
    func initCell(cellData: PropertiesModel, index: Int, section: Int){
        txtFiels.text = ""
        self.section = section
        self.index = index
        if (cellData.options != nil) && cellData.options?.count == 0{
            chooseCategoriesBtn.isHidden = true
            arrowImg.isHidden = true
        }else{
            chooseCategoriesBtn.isHidden = false
            arrowImg.isHidden = false
        }
        titleLbl.customLabel(color: .C515D76, size: .size_13, font: .W400, text: cellData.name ?? "")
        txtFiels.customTxtField(color: .C515D76, size: .size_13, font: .W400, placeholder: "\(LBLs.SELECT.title)\(cellData.name ?? "")", text: cellData.selectedOption ?? "", isPassword: false)
        self.othersView.isHidden = cellData.isOther == nil || cellData.isOther == false ? true:false

    }
    
}
