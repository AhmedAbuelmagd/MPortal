//
//  HomeVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeTV: UITableView!
    @IBOutlet weak var continueBtn: UIButton!
    
    var coordinator: HomeCoordinator?
    private var homeVM: HomeVMProtocol!
    var category = Categories()
    var categoryId = 0
    var childrens: Children?
    var addedProperty = PropertiesModel(name: "select value", options: [])
    var insertedCatId = 0
    var ads_banners: [Ads_banners]?
    var tVCellHeight = 60*iPhoneXFactor
    init(homeVM: HomeVMProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.homeVM = homeVM
    }
    
    var removedChildIDs: [Int] = []
    required init?(coder: NSCoder) { fatalError(ERRORS.VIEW_MODEL_ERROR.title) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func continueBtnBtnClicked(_ sender: Any) {
        coordinator?.productDatails(ads_banners: self.ads_banners ?? [])
    }
}
extension HomeVC{
    func initUI(){
        initTV(tv: homeTV)
        bindViewModel()
        homeVM.getFilterList()
        homeVM.getAllCategories()
        continueBtn.addRadius(radius: 8)
        continueBtn.custom(titleColor: .MainColor, font: .W500, size: .size_14, title: .NEXT_STEP)
    }
    func bindViewModel(){
        
        // MARK: - bind loading
        homeVM.showLoading.bind { [weak self] visible in
            guard let self = self else { return }
            visible ? self.showLoader() : self.hideLoader()
        }
        
        // MARK: - bind error message
        homeVM.onShowError = { message in
            displayMessage(message: message, messageError: true)
        }
        
        // MARK: - bind filterList
        homeVM.filterList.bind { [weak self] filterList in
            guard let self = self else { return }
            self.homeTV.reloadData()
        }
        // MARK: - categoriesData
        homeVM.categoriesData.bind { [weak self] categories in
            guard let self = self else { return }
            self.ads_banners = categories.ads_banners
        }
        homeVM.propertiesList.bind { [weak self] filterList in
            guard let self = self else { return }
            self.homeTV.reloadData()
        }
        // MARK: - bind optionsData
        homeVM.optionsData.bind { [weak self] options in
            guard let self = self else { return }
            var properties = options
            for index in 0..<properties.count{
                properties[index].categoryParentId = self.categoryId
            }
            self.homeVM.propertiesList.value.insert(contentsOf: properties, at: self.insertedCatId + 1)
            self.homeTV.reloadData()
        }
        
    }
    func initTV(tv: UITableView){
        tv.dataSource = self
        tv.delegate = self
        tv.registerNib(cellClass: HomeTVCell.self)
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return homeVM.filterList.value.count
        case 1: return self.homeVM.propertiesList.value.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeTVCell
        switch indexPath.section{
        case 0: cell.initCell(cellData: homeVM.filterList.value[indexPath.row], index: indexPath.row, section: indexPath.section)
        case 1: cell.initCell(cellData: homeVM.propertiesList.value[indexPath.row], index: indexPath.row, section: indexPath.section)
        default: print("")
            
        }
        cell.delegte = self
        return cell
    }
}

extension HomeVC: HomeTVCellDeleget{
    func homeTVCellBtnClicked(index: Int, section: Int, isDate: Bool) {
        switch section{
        case 0:
            switch index{
            case 0: coordinator?.filter(categories: homeVM.categoriesData.value, title: LBLs.CATEGORY.title, delegate: self, type: .Category)
            case 1:
                if let data = self.category.children{
                    coordinator?.filter(title: LBLs.SUB_CATEGORY.title, delegate: self, type: .SubCategory, childrens: data)
                }else{
                    displayMessage(message: LBLs.MAIN_CATEGORY_FIRST.title, messageError: true)
                }
            default: print("")
            }
        case 1:
            
            if (self.homeVM.propertiesList.value[index].options != nil) && self.homeVM.propertiesList.value[index].options?.count != 0{
                coordinator?.filter(title: homeVM.propertiesList.value[index].name ?? "", delegate: self, type: .Options, optionsData: self.homeVM.propertiesList.value[index].options, CategoryIndex: index, categoryId: category.id)
            }
            
        default: print("")
        }
    }
}
extension HomeVC: FilterDeleget{
    func optionClicked(option: [Children], CategoryIndex: Int, child: Bool) {
        self.categoryId = self.homeVM.propertiesList.value[CategoryIndex].id ?? 0
        removeAllAppendedChildOptionWithParentId(parentId: self.categoryId)
        for index in 0..<option.count{
            if option[index].isSelected == true{
                if (option[index].id ?? 0) == 222{
                    self.homeVM.propertiesList.value[CategoryIndex].options = option
                    self.homeVM.propertiesList.value[CategoryIndex].selectedOption = option[index].name ?? ""
                    self.homeVM.propertiesList.value[CategoryIndex].isOther = true
                    for (index, value) in self.homeVM.propertiesList.value.enumerated() {
                        if self.homeVM.propertiesList.value[index].categoryParentId == self.categoryId {
                            mainQueue {
                                self.homeVM.propertiesList.value.remove(at: index)
                            }
                        }
                    }
                }else{
                    self.homeVM.propertiesList.value[CategoryIndex].options = option
                    self.homeVM.propertiesList.value[CategoryIndex].selectedOption = option[index].name ?? ""
                    self.homeVM.propertiesList.value[CategoryIndex].isOther = false
                    if child{
                        homeTV.reloadData()
                        self.insertedCatId = CategoryIndex
                        homeVM.optionId = option[index].id
                        homeVM.getOptionsChild()
                    }
                }
            }
        }
        homeTV.reloadData()
    }
    private func removeAllAppendedChildOptionWithParentId(parentId: Int) {
        removedChildIDs = getParentRemovedChildIds(parentId: parentId)
        getChildForParentRemovedIds(removedIds: removedChildIDs, list: self.homeVM.propertiesList.value)
        self.homeVM.propertiesList.value = self.homeVM.propertiesList.value.filter { !removedChildIDs.contains($0.categoryParentIdValue) }
        homeTV.reloadData()
    }
    private func getParentRemovedChildIds(parentId: Int) -> [Int] {
        return self.homeVM.propertiesList.value.filter({$0.categoryParentIdValue == parentId}).map({$0.categoryParentIdValue})
    }
    private func getChildForParentRemovedIds(removedIds: [Int], list: [PropertiesModel]){
        var newArr: [Int] = []
        for item in list {
            for id in removedIds {
                if item.categoryParentIdValue == id {
                    newArr.append(item.id ?? 0)
                }
            }
        }
        removedChildIDs += newArr
        if newArr.isEmpty {
            return
        }
        return getChildForParentRemovedIds(removedIds: newArr, list: list)
    }
    func categoryClicked(categories: [Categories]) {
        homeVM.categoriesData.value.categories = categories
        for index in 0..<categories.count{
            if categories[index].isSelected == true{
                self.category = categories[index]
                homeVM.propertiesList.value.removeAll()
                homeVM.filterList.value[0].name = category.name ?? ""
                homeVM.filterList.value[1].name = ""
            }
        }
        homeTV.reloadData()
    }
    func subCategoryClicked(childrens: [Children]) {
        for index in 0..<(childrens.count){
            if childrens[index].isSelected == true{
                self.category.children = childrens
                self.childrens = childrens[index]
                homeVM.filterList.value[1].name = childrens[index].name ?? ""
                self.homeVM.cat = "\(childrens[index].id ?? 0)"
                self.homeVM.getProperties()
            }
        }
        homeTV.reloadData()
    }
}
