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

    // MARK: - Properties
    
    var viewModel: ObjectDetailsViewModel!
    var disposeBag = DisposeBag()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureView() {
        super.configureView()
        self.title = "Details"
    }
    
    func bindViewModel() {
    }
}
