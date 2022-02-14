//
//  TestSectionController.swift
//  MuseumApp
//
//  Created by fahid on 07/02/2022.
//

import Foundation
import UIKit
import IGListKit
import Action

final class TestSectionController: ListSectionController {

    var testVM: IGListKitTestViewModelType!

    override init(){
        super.init()
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
        inset = UIEdgeInsets.init(top: 24, left: 16, bottom: 24, right: 16)
    }
    
    override func numberOfItems() -> Int {
        return (try? testVM?.outputs.models.value().count) ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        var size: CGSize = CGSize.zero
        size.height = 150
        size.width = (UIScreen.main.bounds.width - (16*3))/2
        return size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: TestCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! TestCollectionViewCell
        if let model = testVM.outputs.modelAtIndex(index: index) {
            cell.configure(model: model)
            cell.testButton.rx.action = CocoaAction { [weak self] in
                guard let self = self else { return .empty() }
                print("\(model.btnTitle) button tapped")
                self.testVM.inputs.showDetails(model: model)
                return .empty()
            }
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let object = object as? IGListKitTestViewModelType {
            self.testVM = object
        }
    }

    override func didSelectItem(at index: Int) {
    }
}
