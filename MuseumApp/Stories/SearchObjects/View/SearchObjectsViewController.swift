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
        self.title = "Search Museum Arts"
        searchTableView.registerNib(from: SearchResultTableViewCell.self)
        searchTableView.estimatedRowHeight = 44
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.emptyDataSetSource = viewModel
        searchTableView.emptyDataSetDelegate = viewModel
    }
    
    func bindViewModel() {

        // Bind searchbar query text
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance) // Wait for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { query in
                self.viewModel.inputs.searchObjects(searchText: query)
            }).disposed(by: disposeBag)

        searchBar.searchTextField.rx
            .controlEvent([.editingDidEndOnExit]).subscribe { _ in
                self.endEditing()
            }.disposed(by: disposeBag)
        
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
            
        viewModel.outputs.objectDetails
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] artObject in
                guard let self = self else { return }
                let appCoordinator = AppCoordinator(with: self.navigationController)
                appCoordinator.performTransition(.objectDetails(artObject))
            }).disposed(by: disposeBag)

        searchTableView.tableFooterView = UIView()
    }
}
