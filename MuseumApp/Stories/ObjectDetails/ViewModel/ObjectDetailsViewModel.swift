//
//  ObjectDetailsViewModel.swift
//  MuseumApp
//
//  Created by fahid on 30/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ObjectDetailsViewModelInputs {
}

protocol ObjectDetailsViewModelOutputs {
}

protocol ObjectDetailsViewModelType {
    var inputs: ObjectDetailsViewModelInputs {get}
    var outputs: ObjectDetailsViewModelOutputs {get}
}

fileprivate typealias ObjectDetailsViewModelProtocols = ObjectDetailsViewModelInputs & ObjectDetailsViewModelOutputs & ObjectDetailsViewModelType

class ObjectDetailsViewModel: BaseViewModel, ObjectDetailsViewModelProtocols {
    
    // MARK: - ModelType
    var inputs: ObjectDetailsViewModelInputs { return self }
    var outputs: ObjectDetailsViewModelOutputs { return self }
    
    // MARK: - Input
    
    // MARK: - Outputs

    // MARK: - Properties
    private var apiService: MuseumObjectsAPIService!
    private var object: ArtObject!

    // MARK: - Init
    init(apiService: MuseumObjectsAPIService, artObject: ArtObject) {
        self.apiService = apiService
        self.object = artObject
    }
}
