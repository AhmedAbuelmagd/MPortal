//
//  FilterVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

enum filterType{
    case Category
    case SubCategory
    case Options
}
import UIKit

protocol FilterDeleget: NSObjectProtocol {
    func categoryClicked(category: Categories)
    func subCategoryClicked(subcategory: Children)
}

class FilterVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filterTV: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    
    weak var delegte: FilterDeleget?
    
    var type: filterType = .Category
    var coordinator: HomeCoordinator?
    var proId: Int?
    var filterList: CategoriesData?
    var filterChildren: [Children]?
    var childrens = [Children]()
    var categories = [Categories]()
    var optionsData = [Options]()
//    var tVCellHeight = 50*iPhoneXFactor
    var filteTitle = ""
    private var homeVM: HomeVMProtocol!
    init(homeVM: HomeVMProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.homeVM = homeVM
    }
    
    required init?(coder: NSCoder) { fatalError(ERRORS.VIEW_MODEL_ERROR.title) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type{
        case .Category:
            categories = filterList?.categories ?? []
        case .SubCategory:
            childrens = filterChildren ?? []
            print(childrens, "SSSSSSSSSSSS")
        case .Options: print("Option")
            bindViewModel()
            homeVM.optionId = proId
            homeVM.getOptionsChild()
        }
        
        titleLbl.customLabel(color: .C515D76, size: .size_16, font: .W500, text: filteTitle)
        searchView.addRadius(radius: 5*iPhoneXFactor)
        searchTxtField.customTxtField(color: .C515D76, size: .size_14, font: .W400, placeholder: "Search...", text: "", isPassword: false)
        searchTxtField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        initTV(tv: filterTV)
        setupGestureRecognizers()
        mainView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
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
            if searchTxtField.text?.isEmpty == true{ self.optionsData = homeVM.optionsData.value.options ?? [] }
            else{ self.optionsData = ( homeVM.optionsData.value.options ?? []).filter { $0.name?.lowercased().contains(searchTxtField.text?.lowercased() ?? "") ?? false}}
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
        homeVM.optionsData.bind { [weak self] options in
            guard let self = self else { return }
            if let data = options.options{
                self.optionsData = data
            }
            self.filterTV.reloadData()
        }
        
        
    }

}
extension FilterVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type{
        case .Category: return categories.count
        case .SubCategory: return childrens.count
        case .Options: return optionsData.count
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
        case .Options: cell.initCell(cellData: optionsData[indexPath.row])
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
            delegte?.categoryClicked(category: categories[indexPath.row])
        case .SubCategory:
            for index in 0..<(childrens.count){
                childrens[index].isSelected = false
            }
            childrens[indexPath.row].isSelected = true
            delegte?.subCategoryClicked(subcategory: childrens[indexPath.row])
        case .Options: print("")
        }
        
        filterTV.reloadData()
        dismiss(animated: true)
        
    }
}
