//
//  Data+Additions.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

extension Data {
    var json: [String:Any]? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            return json
        }
    }
}
