//
//  Error+Additions.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

enum MAError: LocalizedError {

    case invalidJSONResponse,
         jsonFileMissing(String)

    var errorDescription: String? {
        switch self {
        case .invalidJSONResponse:
            return "Unexpected JSON response."
        case .jsonFileMissing(let fileName):
            return "Unable to find \(fileName).json in main bundle."
        }
    }
}
