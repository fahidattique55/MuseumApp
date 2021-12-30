//
//  EndPoint.swift
//  MuseumApp
//
//  Created by fahid on 12/12/2021.
//

import Foundation

enum Endpoint: URLDirectable {
    
    case searchObjects,
         objectDetails(Int)
    
    var urlString: String {
        var url = ""
        switch self {
        case .searchObjects:
            url = "search"
            break
        case .objectDetails(let id):
            url = "objects/\(id)"
            break
        }
        return NetworkManager.baseURL + "/" + url
    }
}
