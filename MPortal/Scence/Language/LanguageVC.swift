//
//  LanguageVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 17/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH

class LanguageVC: UIViewController {
    
    
    @IBOutlet weak var selectLangLbl: UILabel!
    @IBOutlet weak var hintLbl: UILabel!
    @IBOutlet weak var arabicLbl: UILabel!
    @IBOutlet weak var englishLbl: UILabel!
    @IBOutlet weak var arabicCheckImg: UIImageView!
    @IBOutlet weak var englishCheckImg: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    
    var coordinator: HomeCoordinator?
    let currentLang = MOLHLanguage.currentAppleLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func arabicLanguageBtnClicked(_ sender: UIButton) {
        if currentLang == "en" {
            englishCheckImg.isHidden = true
            arabicCheckImg.isHidden = false
            coordinator?.changeLanguage()
        }
        
    }
    
    @IBAction func englishLanguageBtnClicked(_ sender: UIButton) {
        if currentLang == "ar" {
            englishCheckImg.isHidden = false
            arabicCheckImg.isHidden = true
            coordinator?.changeLanguage()
        }
        
    }
    
    @IBAction func goToHomeBtnClicked(_ sender: UIButton) {
        coordinator?.home()
    }
}
extension LanguageVC{
    func initUI(){
        continueBtn.addRadius(radius: 10)
        continueBtn.addBorder(borderColor: .CDADADA, borderWidth: 1.5)
        continueBtn.custom(titleColor: .CDADADA, size: .size_14, title: .CONTINUE)
        selectLangLbl.customLabel(color: .C515D76, size: .size_18, font: .W600, text: LBLs.SELECT_YOUR_LANG.title)
        hintLbl.customLabel(color: .C515D76, size: .size_12, font: .W400, text: LBLs.LANG_NOTE.title)
        
        if currentLang == "en"{ arabicCheckImg.isHidden = true } else { englishCheckImg.isHidden = true }
        arabicLbl.customLabel(color: .C515D76, size: .size_13, font: .AW600, text: "اللغة العربية")
        englishLbl.customLabel(color: .C515D76, size: .size_13, font: .EW500, text: "English Language")
    }
}
