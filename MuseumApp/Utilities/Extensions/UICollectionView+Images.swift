//
//  UICollectionView+Images.swift
//  MuseumApp
//
//  Created by fahid on 31/12/2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerNib(from cellClass: UICollectionViewCell.Type) {
        let cellInfo = cellClass.identifier
        register(UINib(nibName: cellInfo, bundle: nil), forCellWithReuseIdentifier: cellInfo)
    }
    
    func registerNib(headerClass: UICollectionReusableView.Type) {

        let cellInfo = headerClass.identifier
        register(UINib(nibName: cellInfo, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellInfo)
    }

    func registerNib(footerClass: UICollectionReusableView.Type) {
        
        let cellInfo = footerClass.identifier
        register(UINib(nibName: cellInfo, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellInfo)
    }
    
    func dequeue<T: UICollectionViewCell>(cell: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T
    }
}
