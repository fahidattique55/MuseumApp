//
//  TestModel.swift
//  MuseumApp
//
//  Created by fahid on 07/02/2022.
//

import Foundation
import IGListKit

class TestModel: NSObject {
    var id = 0
    var lblTitle = ""
    var btnTitle = ""
    
    convenience init(id: Int, lblTitle: String, btnTitle: String) {
        self.init()
        self.id = id
        self.lblTitle = lblTitle
        self.btnTitle = btnTitle
    }
}

extension TestModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? TestModel else { return false }
        return id == object.id
    }
}
