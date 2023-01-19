//
//  HomeVM.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
//import RxSwift
//import RxCocoa


protocol HomeVMProtocol: BaseVMProtocol {
    
    // MARK: - Properties
    var cat: String? { get set }
    var optionId: Int? { get set }
    var filterList: Bindable<[Filter]> { get set }
    var propertiesList: Bindable<[PropertiesModel]> { get set }
    var categoriesData: Bindable<CategoriesData> {get set}
    var optionsData: Bindable<[PropertiesModel]> {get set}
    
    // MARK: - methods
    func getAllCategories()
    func getFilterList()
    func getProperties()
    func getOptionsChild()
    
}

class HomeVM: HomeVMProtocol {
    var cat: String?
    var optionId: Int?
    var categoriesData = Bindable<CategoriesData>(CategoriesData())
    var optionsData = Bindable<[PropertiesModel]>([])
    
    // MARK: - Properties
    @Published private (set) var tasks: [Filter] = []
    let apiClient: HomeNetworkProtocol
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((String) -> Void)?
    var onShowSuccess: ((String) -> Void)?
    var filterList = Bindable<[Filter]>([])
    var propertiesList = Bindable<[PropertiesModel]>([])
    init(apiClient: HomeNetworkProtocol) {
        self.apiClient = apiClient
    }
    
    func getOptionsChild() {
        if checkConnection(){
            showLoading.value = true
            apiClient.getOptionsChild(id: optionId ?? 0) { [weak self] Result in
                guard let self = self else { return }
                self.showLoading.value = false
                switch Result{
                case .success(let response):
                    if let data = response.data {
                        self.optionsData.value = data
                    }
                case .failure(let error): self.onShowError?(error.localizedDescription)
                }
            }
        }
    }
    
    func getProperties() {
        if checkConnection(){
            showLoading.value = true
            apiClient.getProperties(cat: cat ?? "") { [weak self] Result in
                guard let self = self else { return }
                self.showLoading.value = false
                switch Result{
                case .success(let response):
                    var data = response.data
                    for index in 0..<(data?.count ?? 0){
                        if data?[index].options?.count != 0{
                            data?[index].options?.insert(Children(id: 222, name: LBLs.OTHER.title, child: false), at: 0)
                            self.propertiesList.value = data ?? []
                        }
                    }
                case .failure(let error): self.onShowError?(error.localizedDescription)
                }
            }
        }
    }
    // MARK: - methods
    func getAllCategories() {
        if checkConnection(){
            showLoading.value = true
            apiClient.getAllCategories() { [weak self] Result in
                guard let self = self else { return }
                self.showLoading.value = false
                switch Result{
                case .success(let response):
                    print(response)
                    if let categories = response.data {
                        self.categoriesData.value = categories
                    }
                case .failure(let error): self.onShowError?(error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func getFilterList() {
        guard let settingsURL = Bundle.main.url(forResource: FileName.FILTER_LIST.rawValue, withExtension: Extensions.JSON.rawValue) else { return }
        do {
            let data = try Data(contentsOf: settingsURL)
            let list = try JSONDecoder().decode([Filter].self, from: data)
            self.filterList.value = list
        } catch {
            print(error)
        }
    }
    
    func checkConnection() -> Bool{
        if !Internet.isConnected(){
            self.onShowError?(ERRORS.CHECK_INTERNET_CONNECTION.title)
            return false
        }
        return true
    }
}
