//
//  BaseViewModel.swift
//  MuseumApp
//
//  Created by fahid on 29/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModelType {
    var baseInputs: BaseViewModelInputType {get}
    var baseOutputs: BaseViewModelOutputType {get}
}

protocol BaseViewModelInputType { }

protocol BaseViewModelOutputType {
    var showHud: PublishSubject<Bool> {get set}
    var error: PublishSubject<Error> {get set}
}

fileprivate typealias BaseViewModelProtocols = BaseViewModelType & BaseViewModelInputType & BaseViewModelOutputType

class BaseViewModel: NSObject, BaseViewModelProtocols {
    
    // MARK: - ModelType
    var baseInputs: BaseViewModelInputType { return self }
    var baseOutputs: BaseViewModelOutputType { return self }
    
    // MARK: - Input

    // MARK: - Outputs
    var showHud: PublishSubject<Bool> = PublishSubject<Bool>()
    var error: PublishSubject<Error> = PublishSubject<Error>()
}

protocol BindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    var disposeBag: DisposeBag { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {

    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        if let baseViewModel = viewModel as? BaseViewModelType {
            bindBaseViewModel(baseViewModel)
        }
        bindViewModel()
    }
    
    private func bindBaseViewModel(_ viewModel: BaseViewModelType) {
        viewModel.baseOutputs.showHud
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] showHud in
                guard let self = self else { return }
                if showHud {
                    self.showHUD()
                }
                else {
                    self.hideHUD()
                }
        }).disposed(by: disposeBag)
        
        viewModel.baseOutputs.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                UIAlertController.showAlert(error, on: self)
        })
        .disposed(by: disposeBag)
    }
}
