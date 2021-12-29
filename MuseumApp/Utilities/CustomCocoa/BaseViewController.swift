//
//  BaseViewController.swift
//  MuseumApp
//
//  Created by fahid on 29/12/2021.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

protocol ViewConfigurable {
    func configureView()
}

class BaseViewController: UIViewController, ViewConfigurable {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureView() {
    }
}
