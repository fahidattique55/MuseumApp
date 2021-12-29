//
//  UITableView+Additions.swift
//  MuseumApp
//
//  Created by fahid on 30/12/2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib(from cellClass: UITableViewCell.Type) {
        let identifier = cellClass.identifier
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func registerCell(from cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeue<T: UITableViewCell>(cell: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cell.identifier) as? T
    }
 
    
    func registerNib(from headerFooterClass: UITableViewHeaderFooterView.Type) {
        let identifier = headerFooterClass.identifier
        register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    
    func dequeue<T: UITableViewHeaderFooterView>(headerFooter: UITableViewHeaderFooterView.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: headerFooter.identifier) as? T
    }
}
