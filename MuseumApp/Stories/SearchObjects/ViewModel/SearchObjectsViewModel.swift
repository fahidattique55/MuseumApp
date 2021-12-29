//
//  SearchObjectsViewModel.swift
//  MuseumApp
//
//  Created by fahid on 20/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchObjectsViewModelInputs {
    func searchObjects(searchText: String)
    func itemSelected(objectID: Int)
}

protocol SearchObjectsViewModelOutputs {
    var searchResults: BehaviorSubject<[Int]> {get set}
}

protocol SearchObjectsViewModelType {
    var inputs: SearchObjectsViewModelInputs {get}
    var outputs: SearchObjectsViewModelOutputs {get}
}

fileprivate typealias SearchObjectsViewModelProtocols = SearchObjectsViewModelInputs & SearchObjectsViewModelOutputs & SearchObjectsViewModelType

class SearchObjectsViewModel: BaseViewModel, SearchObjectsViewModelProtocols {
    
    // MARK: - ModelType
    var inputs: SearchObjectsViewModelInputs { return self }
    var outputs: SearchObjectsViewModelOutputs { return self }
    
    // MARK: - Input
    
    func itemSelected(objectID: Int) {
        
    }
    
    func searchObjects(searchText: String) {
        self.baseOutputs.showHud.onNext(true)
        let params = ["q":searchText]
        apiService.searchObjectIDs(params: params) { [weak self] result in
            guard let self = self else { return }
            self.baseOutputs.showHud.onNext(false)
            switch result {
            case .success(let objectIDs):
                self.objectIDs = objectIDs
                self.outputs.searchResults.onNext(objectIDs)
                break
            case.failure(let error):
                self.baseOutputs.error.onNext(error)
                break
            }
        }
    }

    // MARK: - Outputs
    var searchResults: BehaviorSubject<[Int]> = BehaviorSubject<[Int]>(value: [])

    // MARK: - Properties
    private var apiService: MuseumObjectsAPIService!
    private var objectIDs = [Int]()


    // MARK: - Init
    init(apiService: MuseumObjectsAPIService) {
        self.apiService = apiService
    }
}
