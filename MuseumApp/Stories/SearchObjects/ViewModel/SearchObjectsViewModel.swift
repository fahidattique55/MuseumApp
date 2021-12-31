//
//  SearchObjectsViewModel.swift
//  MuseumApp
//
//  Created by fahid on 20/12/2021.
//

import Foundation
import RxSwift
import RxCocoa
import DZNEmptyDataSet

protocol SearchObjectsViewModelInputs {
    func searchObjects(searchText: String)
    func itemSelected(at index: Int)
}

protocol SearchObjectsViewModelOutputs {
    var searchResults: BehaviorSubject<[Int]> {get set}
    var objectDetails: PublishSubject<ArtObject> {get set}
}

protocol SearchObjectsViewModelType: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    var inputs: SearchObjectsViewModelInputs {get}
    var outputs: SearchObjectsViewModelOutputs {get}
}

fileprivate typealias SearchObjectsViewModelProtocols = SearchObjectsViewModelInputs & SearchObjectsViewModelOutputs & SearchObjectsViewModelType

class SearchObjectsViewModel: BaseViewModel, SearchObjectsViewModelProtocols {
    
    // MARK: - ModelType
    var inputs: SearchObjectsViewModelInputs { return self }
    var outputs: SearchObjectsViewModelOutputs { return self }
    
    // MARK: - Input
    
    func itemSelected(at index: Int) {
        guard let objectIDs = try? searchResults.value() else { return }
        guard let objectID = objectIDs[safe: index] else { return }
        self.baseOutputs.showHud.onNext(true)
        apiService.getDetails(objectID: objectID, result: { [weak self] result in
            guard let self = self else { return }
            self.baseOutputs.showHud.onNext(false)
            switch result {
            case .success(let object):
                self.objectDetails.onNext(object)
                break
            case.failure(let error):
                self.baseOutputs.error.onNext(error)
                break
            }
        })
    }
    
    func searchObjects(searchText: String) {
        if searchText.count < self.minimumCharactersToTriggerSearch {
            self.canShowNoResultsFound = false
            self.outputs.searchResults.onNext([Int]())
            return
        }
        self.canShowNoResultsFound = true
        self.baseOutputs.showHud.onNext(true)
        var params = [String:Any]()
        params["q"] = searchText
        params["hasImages"] = true
        apiService.searchObjectIDs(params: params) { [weak self] result in
            guard let self = self else { return }
            self.baseOutputs.showHud.onNext(false)
            switch result {
            case .success(let objectIDs):
                self.outputs.searchResults.onNext(objectIDs)
                break
            case.failure(let error):
                self.baseOutputs.error.onNext(error)
                break
            }
        }
    }

    // MARK: - Outputs
    var searchResults = BehaviorSubject<[Int]>(value: [])
    var objectDetails = PublishSubject<ArtObject>()

                              
    // MARK: - Properties
    private var apiService: MuseumObjectAPIs!
    private var canShowNoResultsFound = false
    private var minimumCharactersToTriggerSearch = 3

    // MARK: - Init
    init(apiService: MuseumObjectAPIs) {
        self.apiService = apiService
    }
}

extension SearchObjectsViewModel: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let attributes = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle : paragraph]
        var message = ""
        if canShowNoResultsFound {
            message = "No Search Results Found."
        }
        else {
            message = "Minimum \(minimumCharactersToTriggerSearch) characters required to start searching."
        }
        
        return NSAttributedString(string: message, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.clear
    }
}

extension SearchObjectsViewModel : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        let topAreaInsets = UIDevice.safeAreaInsetsTop
        return -(topAreaInsets)
    }
}
