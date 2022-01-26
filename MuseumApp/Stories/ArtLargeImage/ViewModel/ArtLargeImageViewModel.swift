//
//  ArtLargeImageViewModel.swift
//  MuseumApp
//
//  Created by fahid on 26/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArtLargeImageViewModelInputs {
}

protocol ArtLargeImageViewModelOutputs {
    var imageURL: BehaviorSubject<String> {get set}
}

protocol ArtLargeImageViewModelType {
    var inputs: ArtLargeImageViewModelInputs {get}
    var outputs: ArtLargeImageViewModelOutputs {get}
}

fileprivate typealias ArtLargeImageViewModelProtocols = ArtLargeImageViewModelInputs & ArtLargeImageViewModelOutputs & ArtLargeImageViewModelType

class ArtLargeImageViewModel: BaseViewModel, ArtLargeImageViewModelProtocols {

    // MARK: - ModelType
    var inputs: ArtLargeImageViewModelInputs { return self }
    var outputs: ArtLargeImageViewModelOutputs { return self }
    
    // MARK: - Input
    
    // MARK: - Outputs
    var imageURL = BehaviorSubject<String>(value: "")

    // MARK: - Properties
    var object: ArtObject!

    // MARK: - Init
    init(imageURL: String) {
        self.imageURL.onNext(imageURL)
    }
}
