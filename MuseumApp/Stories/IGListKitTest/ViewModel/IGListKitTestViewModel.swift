//
//  IGListKitTestViewModel.swift
//  MuseumApp
//
//  Created by fahid on 07/02/2022.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit

protocol IGListKitTestViewModelInputs {
    func showDetails(model: TestModel)
}

protocol IGListKitTestViewModelOutputs {
    var models: BehaviorSubject<[TestModel]> {get set}
    func modelAtIndex(index: Int) -> TestModel?
}

protocol IGListKitTestViewModelType: ListDiffable {
    var inputs: IGListKitTestViewModelInputs {get}
    var outputs: IGListKitTestViewModelOutputs {get}
}

fileprivate typealias IGListKitTestViewModelProtocols = IGListKitTestViewModelInputs & IGListKitTestViewModelOutputs & IGListKitTestViewModelType

class IGListKitTestViewModel: BaseViewModel, IGListKitTestViewModelProtocols {
    
    // MARK: - ModelType
    var inputs: IGListKitTestViewModelInputs { return self }
    var outputs: IGListKitTestViewModelOutputs { return self }
    
    // MARK: - Input
    func showDetails(model: TestModel) {
        print("Showing details of \(model.lblTitle)")
    }
    
    // MARK: - Outputs
    var models = BehaviorSubject<[TestModel]>(value: [])
    func modelAtIndex(index: Int) -> TestModel? {
        guard let models = try? self.models.value() else { return nil }
        let model = models[index]
        return model
    }

    // MARK: - Properties

    // MARK: - Init
    override init() {
        super.init()
        var models = [TestModel]()
        for i in 1..<101 {
            let model = TestModel(id: i, lblTitle: "Label \(i)", btnTitle: "Button \(i)")
            models.append(model)
        }
        self.models.onNext(models)
    }
}


extension IGListKitTestViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? TestModel else { return false }
        return self == object
    }
}
