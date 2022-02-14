//
//  IGListKitTestViewController.swift
//  MuseumApp
//
//  Created by fahid on 07/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit

class IGListKitTestViewController: BaseViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var itemsCollectionView: ListCollectionView!

    // MARK: - Properties
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var viewModel: IGListKitTestViewModelType!
    var disposeBag = DisposeBag()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("deinit Called")
    }
    
    override func configureView() {
        super.configureView()
        self.title = "IGListKit MVVM-Rx"
        adapter.collectionView = itemsCollectionView
        adapter.dataSource = self
        itemsCollectionView.delaysContentTouches = false
    }
    
    func bindViewModel() {
    }
}

extension IGListKitTestViewController: ListAdapterDataSource{
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [self.viewModel]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return TestSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}



