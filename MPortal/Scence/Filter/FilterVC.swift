//
//  FilterVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//


import UIKit

protocol FilterDeleget: NSObjectProtocol {
    func categoryClicked(categories: [Categories])
    func subCategoryClicked(childrens: [Children])
    func optionClicked(option: [Children], CategoryIndex: Int, child: Bool)
}

class FilterVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filterTV: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    
    weak var delegte: FilterDeleget?
    var type: FilterType = .Category
    var coordinator: HomeCoordinator?
    var proId: Int?
    var filterList: CategoriesData?
    var filterChildren: [Children]?
    var childrens = [Children]()
    var categories = [Categories]()
    var optionsData: [Children]?
    var options = [Children]()
    var CategoryIndex: Int?
    var categoryId: Int?
    
    var filteTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    @IBAction func dismissBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch type{
        case .Category:
            if searchTxtField.text?.isEmpty == true{ self.categories = filterList?.categories ?? [] }
            else{ self.categories = ( filterList?.categories ?? []).filter { $0.name?.lowercased().contains(searchTxtField.text?.lowercased() ?? "") ?? false}}
        case .SubCategory:
            if searchTxtField.text?.isEmpty == true{ self.childrens = filterChildren ?? [] }
            else{ self.childrens = ( filterChildren ?? []).filter { $0.name?.lowercased().contains(searchTxtField.text?.lowercased() ?? "") ?? false}}
        case .Options: print("")
            if searchTxtField.text?.isEmpty == true{ self.options = optionsData ?? [] }
            else{ self.options = ( optionsData ?? []).filter { $0.name?.lowercased().contains(searchTxtField.text?.lowercased() ?? "") ?? false}}
        }
        
        
        filterTV.reloadData()
    }
    
    private func setupGestureRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        self.dismiss(animated: true)
    }
    func initTV(tv: UITableView){
        tv.dataSource = self
        tv.delegate = self
        tv.registerNib(cellClass: FilterTVCell.self)
        tv.estimatedRowHeight = 300
    }
    
}
extension FilterVC{
    func initUI(){
        switch type{
        case .Category:
            categories = filterList?.categories ?? []
        case .SubCategory:
            childrens = filterChildren ?? []
        case .Options: options = optionsData ?? []
        }
        
        titleLbl.customLabel(color: .C515D76, size: .size_16, font: .W700, text: filteTitle)
        searchView.addRadius(radius: 5*iPhoneXFactor)
        searchTxtField.customTxtField(color: .C515D76, size: .size_13, font: .W400, placeholder: LBLs.SEARCH.title, text: "", isPassword: false)
        searchTxtField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        initTV(tv: filterTV)
        setupGestureRecognizers()
        mainView.layer.cornerRadius = 20
    }
}


extension FilterVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type{
        case .Category: return categories.count
        case .SubCategory: return childrens.count
        case .Options: return options.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as FilterTVCell
        switch type{
        case .Category: cell.initCell(cellData: categories[indexPath.row])
        case .SubCategory: cell.initCell(cellData: childrens[indexPath.row])
        case .Options: cell.initCell(cellData: options[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type{
        case .Category:
            for index in 0..<(categories.count){
                categories[index].isSelected = false
            }
            categories[indexPath.row].isSelected = true
            
            let categoryId = categories[indexPath.row].id
            for catIndex in 0..<(filterList?.categories?.count ?? 0){
                if filterList?.categories?[catIndex].id == categoryId{
                    filterList?.categories?[catIndex].isSelected = true
                }else{
                    filterList?.categories?[catIndex].isSelected = false
                }
            }
            delegte?.categoryClicked(categories: filterList?.categories ?? [])
            
        case .SubCategory:
            for index in 0..<(childrens.count){
                childrens[index].isSelected = false
            }
            childrens[indexPath.row].isSelected = true
            
            
            //
            let categoryId = childrens[indexPath.row].id
            for catIndex in 0..<(filterChildren?.count ?? 0){
                if filterChildren?[catIndex].id == categoryId{
                    filterChildren?[catIndex].isSelected = true
                }else{
                    filterChildren?[catIndex].isSelected = false
                }
            }
            delegte?.subCategoryClicked(childrens: filterChildren ?? [])
            
            
            
            
        case .Options:
            for index in 0..<(options.count){
                options[index].isSelected = false
            }
            options[indexPath.row].isSelected = true
            //
            let categoryId = options[indexPath.row].id
            
            for catIndex in 0..<(optionsData?.count ?? 0){
                if optionsData?[catIndex].id == categoryId{
                    optionsData?[catIndex].isSelected = true
                }else{
                    optionsData?[catIndex].isSelected = false
                }
            }
            
            
            //optionsData
            
            delegte?.optionClicked(option: optionsData ?? [], CategoryIndex: CategoryIndex ?? 0, child: options[indexPath.row].child ?? false)
        }
        
        filterTV.reloadData()
        dismiss(animated: true)
        
    }
}
