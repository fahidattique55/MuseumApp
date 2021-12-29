//
//  SearchObjectsViewController.swift
//  MuseumApp
//
//  Created by fahid on 20/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchObjectsViewController: BaseViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties
    
    var viewModel: SearchObjectsViewModelType!
    var disposeBag = DisposeBag()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureView() {
        super.configureView()
        searchTableView.registerNib(from: SearchResultTableViewCell.self)
        searchTableView.estimatedRowHeight = 44
        searchTableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindViewModel() {

        // Bind searchbar query text
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty && $0.count > 3 }
            .subscribe(onNext: { query in
                self.viewModel.inputs.searchObjects(searchText: query)
            }).disposed(by: disposeBag)


        // Bind didSelect of tableview
        searchTableView.rx.modelSelected(Int.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                self.viewModel.inputs.itemSelected(objectID: model)
            }).disposed(by: disposeBag)
        
        // Bind search results and tableview
        viewModel.outputs.searchResults.asObservable()
            .bind(to: searchTableView.rx.items(cellIdentifier: SearchResultTableViewCell.identifier, cellType: SearchResultTableViewCell.self)) { index, element, cell in
                cell.objectIDLabel.text = "\(element)"
        }.disposed(by: disposeBag)
            
        searchTableView.tableFooterView = UIView()
    }
}
