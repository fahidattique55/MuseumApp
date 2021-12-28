//
//  NSObjectProtocol+Additions.swift
//  MuseumApp
//
//  Created by fahid on 21/12/2021.
//

import Foundation

extension NSObjectProtocol {
    static var identifier: String { return String(describing: self) }
}
