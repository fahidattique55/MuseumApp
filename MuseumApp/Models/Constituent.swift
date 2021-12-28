//
//  Constituent.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

struct Constituent: Codable {
    var constituentID: Int
    var role: String
    var name: String
    var constituentULAN_URL: String
    var constituentWikidata_URL: String
    var gender: String
}

