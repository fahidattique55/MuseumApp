//
//  Error+Additions.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

enum MAError: Error {

    case invalidJSONResponse,
         jsonFileMissing(String)

    var localizedDescription: String {
        switch self {
        case .invalidJSONResponse:
            return "Unexpected JSON response."
        case .jsonFileMissing(let fileName):
            return "Unable to find \(fileName).json in main bundle."
        }
    }
}
