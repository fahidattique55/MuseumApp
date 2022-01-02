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
        searchBar.becomeFirstResponder()
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
        searchTableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              guard let self = self else { return }
              self.searchTableView.deselectRow(at: indexPath, animated: true)
              self.viewModel.inputs.itemSelected(at: indexPath.row)
          }).disposed(by: disposeBag)
        
        // Bind search results and tableview
        viewModel.outputs.searchResults
            .bind(to: searchTableView.rx.items(cellIdentifier: SearchResultTableViewCell.identifier, cellType: SearchResultTableViewCell.self)) { index, element, cell in
                cell.objectIDLabel.text = "\(element)"
        }.disposed(by: disposeBag)
            
        viewModel.outputs.objectDetails
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] artObject in
                guard let self = self else { return }
                guard let object = artObject else { return }
                let appCoordinator = AppCoordinator(with: self.navigationController)
                appCoordinator.performTransition(.objectDetails(object))
            }).disposed(by: disposeBag)

        searchTableView.tableFooterView = UIView()
    }
}
