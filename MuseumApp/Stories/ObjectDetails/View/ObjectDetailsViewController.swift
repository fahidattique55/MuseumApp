//
//  ObjectDetailsViewController.swift
//  MuseumApp
//
//  Created by fahid on 30/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ObjectDetailsViewController: BaseViewController, BindableType {
    
    // MARK: - IBOutlets

    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    
    // MARK: - Properties
    
    var viewModel: ObjectDetailsViewModelType!
    var disposeBag = DisposeBag()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureView() {
        super.configureView()
        self.title = "Details"
        detailsTableView.registerNib(from: ObjectDetailsSimpleTableViewCell.self)
        detailsTableView.estimatedRowHeight = 60
        detailsTableView.rowHeight = UITableView.automaticDimension
        imagesCollectionView.registerNib(from: ObjectImagesCollectionViewCell.self)
    }
    
    func bindViewModel() {
        imagesPageControl.hidesForSinglePage = true
        imagesPageControl.numberOfPages = viewModel.outputs.totalImagesCount

        // Binding collectionview
        viewModel.outputs.imagesDataSource
            .bind(to: imagesCollectionView.rx.items(cellIdentifier: ObjectImagesCollectionViewCell.identifier, cellType: ObjectImagesCollectionViewCell.self)) { index, element, cell in
                cell.configureImage(url: element)
        }.disposed(by: disposeBag)

        imagesCollectionView.rx.contentOffset.subscribe { [weak self] value in
            guard let self = self else { return }
            guard let contentOffset = value.element else { return }
            self.imagesPageControl.currentPage = Int(contentOffset.x) / Int(self.imagesCollectionView.frame.width)
        }.disposed(by: disposeBag)
        
        imagesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

        // Binding tableview
        viewModel.outputs.tableViewDataSource
            .bind(to: detailsTableView.rx.items(cellIdentifier: ObjectDetailsSimpleTableViewCell.identifier, cellType: ObjectDetailsSimpleTableViewCell.self)) { index, element, cell in
                let data = self.viewModel.outputs.dataForRowType(element)
                cell.headingLabel.text = data.0
                if let details = data.1 {
                    cell.objectDetailsLabel.text = details.isEmpty ? "N/A" : details
                }
                else {
                    cell.objectDetailsLabel.text = "N/A"
                }
        }.disposed(by: disposeBag)
    }
}

extension ObjectDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
