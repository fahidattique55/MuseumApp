//
//  EndPoint+Mocking.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

protocol MockType {
    var mockFileName: String { get }
}

extension Endpoint: MockType {
    var mockFileName: String {
        switch self {
        case .searchObjects:
            return "SearchObjects"
        case .objectDetails(_):
            return "ObjectDetails"
        }
    }
}
