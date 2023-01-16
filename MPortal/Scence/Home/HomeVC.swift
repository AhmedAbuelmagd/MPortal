//
//  HomeVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import Combine

import RxSwift
import RxCocoa

class HomeVC: UIViewController {

    var coordinator: HomeCoordinator?
    let disposeBag = DisposeBag()
    private var homeVM: HomeVMProtocol!
    var category = Categories()
    var childrens = Children()
    @IBOutlet weak var homeTV: UITableView!
    @IBOutlet weak var fff: UIButton!
    var tVCellHeight = 60*iPhoneXFactor
    init(homeVM: HomeVMProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.homeVM = homeVM
    }
    
    required init?(coder: NSCoder) { fatalError(ERRORS.VIEW_MODEL_ERROR.title) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTV(tv: homeTV)
        bindViewModel()
        homeVM.getFilterList()
        homeVM.getAllCategories()
    }
    
    @IBAction func fdfdf(_ sender: Any) {
        coordinator?.productDatails()
    }
}
extension HomeVC{
    func bindViewModel(){
        
        // MARK: - bind loading
        homeVM.showLoading.bind { [weak self] visible in
            guard let self = self else { return }
//            visible ? self.showLoader() : self.hideLoader()
        }
        
        // MARK: - bind error message
        homeVM.onShowError = { message in
//            displayMessage(message: message, messageError: true)
        }
        
        // MARK: - bind success message
        homeVM.filterList.bind { [weak self] filterList in
            guard let self = self else { return }
            self.homeTV.reloadData()
        }
        homeVM.categoriesData.bind { [weak self] filterList in
            guard let self = self else { return }
//            self.homeTV.reloadData()
        }
        homeVM.propertiesList.bind { [weak self] filterList in
            guard let self = self else { return }
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
//        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tVCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeTVCell
        switch indexPath.section{
        case 0: cell.initCell(cellData: homeVM.filterList.value[indexPath.row], index: indexPath.row, section: indexPath.section)
        case 1: cell.initCell(cellData: homeVM.propertiesList.value[indexPath.row], index: indexPath.row, section: indexPath.section)
        default: print("")
                            
        }
//        switch section{
//        case 0: cell.initCell(title: homeVM.filterList.value[])
//        case 1: return self.category.children?.count ?? 0
//        case 2: return 1
//        default: return 0
//        }
        cell.delegte = self
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        switch indexPath.section{
////        case 0:
////            switch indexPath.row{
////            case 0: coordinator?.filter(categories: homeVM.categoriesData.value, title: "Category", delegate: self, type: .Category)
////            case 1:
////                if let data = self.category.children{
////                coordinator?.filter(title: "Sub category", delegate: self, type: .SubCategory, childrens: data)
////                print(self.category.children?.count, "vdvdvdv")
////            }else{
////                print(self.category.children?.count, "vdvdvdv")
////
////            }
////            default: print("")
////            }
////        case 1:
////            if self.homeVM.propertiesList.value[indexPath.row].options?.count != 0{
////                print(indexPath.section, self.homeVM.propertiesList.value[indexPath.row].options?.count, "have data opbdfbdfbdfbdfbdf")
////            }else{
////                print("not have opbdfbdfbdfbdfbdf")
////            }
////
////        default: print("")
////        }
//    }
}

extension HomeVC: HomeTVCellDeleget{
    func homeTVCellBtnClicked(index: Int, section: Int, isDate: Bool) {
        switch section{
        case 0:
            switch index{
            case 0:
                coordinator?.filter(categories: homeVM.categoriesData.value, title: "Category", delegate: self, type: .Category)
            case 1:
                if let data = self.category.children{
                coordinator?.filter(title: "Sub category", delegate: self, type: .SubCategory, childrens: data)
                print(self.category.children?.count, "vdvdvdv")
            }else{
                print(self.category.children?.count, "vdvdvdv")
                
            }
            default: print("")
            }
        case 1:
            if self.homeVM.propertiesList.value[index].options?.count != 0{
                coordinator?.filter(title: homeVM.propertiesList.value[index].name ?? "", delegate: self, type: .Options, proId: homeVM.propertiesList.value[index].id ?? 0)
//                print(indexPath.section, self.homeVM.propertiesList.value[index].options?.count, "have data opbdfbdfbdfbdfbdf")
            }else{
                print("not have opbdfbdfbdfbdfbdf")
            }
            
        default: print("")
        }
//        coordinator?.filter(filterList: homeVM.categoriesData.value, title: "Category", delegate: self, type: .Category)
    }
}
extension HomeVC: FilterDeleget{
    func subCategoryClicked(subcategory: Children) {
        self.homeVM.cat = "\(subcategory.id ?? 0)"
        self.homeVM.getProperties()
        self.childrens = subcategory
        homeVM.filterList.value[1].name = subcategory.name ?? ""
        homeTV.reloadData()
    }
    
    func categoryClicked(category categort: Categories) {
        homeVM.filterList.value[0].name = categort.name ?? ""
        self.category = categort
        homeTV.reloadData()
    }
}
