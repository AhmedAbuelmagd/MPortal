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
    var optionsData: Bindable<OptionModel> {get set}

    
    
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
    var optionsData = Bindable<OptionModel>(OptionModel())

    // MARK: - Properties
    @Published private (set) var tasks: [Filter] = []
    let apiClient: HomeNetworkProtocol
    //    let reachability = CheckConnection()
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
                    if let data = response.data?.first {
                        self.optionsData.value = data
                    }
                case .failure(let error): self.onShowError?(error.localizedDescription)
                    print(error.localizedDescription, "sdfghjkjhgfdsdfghjkl")
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
                    if let data = response.data {
                        self.propertiesList.value = data
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
            //            let obj = IsPhoneExistsPModel(phone: phoneBehavior.value)
            apiClient.getAllCategories() { [weak self] Result in
                guard let self = self else { return }
                self.showLoading.value = false
                switch Result{
                case .success(let response):
                    print(response)
                    if let categories = response.data {
                        self.categoriesData.value = categories
                    }
                    //                    guard let isExists = response.result?.isExists else { return }
                    //                    self.isPhoneExist.onNext(isExists)
                case .failure(let error): self.onShowError?(error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    func getFilterList() {
        guard let settingsURL = Bundle.main.url(forResource: "FiltersList", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: settingsURL)
            let list = try JSONDecoder().decode([Filter].self, from: data)
            self.filterList.value = list
        } catch {
            print("245434565434 1")
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
