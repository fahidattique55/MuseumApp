//
//  ObjectDetailsViewModel.swift
//  MuseumApp
//
//  Created by fahid on 30/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum ObjectDetailsTableViewRowType: CaseIterable {
    case title,
         artistDisplayName,
         id,
         objectName,
         isHighlight,
         accessionNumber,
         accessionYear,
         creditLine,
         department,
         classification
}

protocol ObjectDetailsViewModelInputs {
}

protocol ObjectDetailsViewModelOutputs {
    var tableViewDataSource: BehaviorSubject<[ObjectDetailsTableViewRowType]>! {get set}
    var imagesDataSource: BehaviorSubject<[String]>! {get set}
    var totalImagesCount: Int {get}
    func dataForRowType(_ rowType: ObjectDetailsTableViewRowType) -> (String,String?)
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
    var tableViewDataSource: BehaviorSubject<[ObjectDetailsTableViewRowType]>!
    var imagesDataSource: BehaviorSubject<[String]>!
    var totalImagesCount: Int {
        guard let count = try? imagesDataSource.value().count else { return 0 }
        return count
    }
    func dataForRowType(_ rowType: ObjectDetailsTableViewRowType) -> (String,String?) {
        switch rowType {
        case .title:
            return ("Title", object.title)
        case .artistDisplayName:
            return ("Artist Name", object.artistDisplayName)
        case .id:
            return ("Art ID", "\(object.objectID ?? 0)")
        case .objectName:
            return ("Art Name", object.objectName)
        case .isHighlight:
            return ("Highlight", (object.isHighlight ?? false) ? "Yes" : "No")
        case .accessionNumber:
            return ("Accession Number", object.accessionNumber)
        case .accessionYear:
            return ("Accession Year", object.accessionYear)
        case .creditLine:
            return ("Credit Line", object.creditLine)
        case .department:
            return ("Department", object.department)
        case .classification:
            return ("Classification", object.classification)
        }
    }
    
    // MARK: - Properties
    var apiService: MuseumObjectAPIs!
    var object: ArtObject!

    // MARK: - Init
    init(apiService: MuseumObjectAPIs, artObject: ArtObject) {
        self.apiService = apiService
        self.object = artObject
        self.tableViewDataSource = BehaviorSubject<[ObjectDetailsTableViewRowType]>(value: ObjectDetailsTableViewRowType.allCases)
        self.imagesDataSource = BehaviorSubject<[String]>(value: artObject.allImages)
    }
}
