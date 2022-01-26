//
//  ArtLargeImageViewController.swift
//  MuseumApp
//
//  Created by fahid on 26/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ArtLargeImageViewController: BaseViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var artLargeImageView: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: ArtLargeImageViewModelType!
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
        self.title = "Large Image"
    }
    
    func bindViewModel() {
        viewModel.outputs.imageURL
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                if url.isEmpty { return }
                self.artLargeImageView.setImage(url: url, success: nil)
            }).disposed(by: disposeBag)
    }
}
