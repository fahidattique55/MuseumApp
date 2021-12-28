//
//  API.swift
//  MuseumApp
//
//  Created by fahid on 12/12/2021.
//

import Foundation
import Alamofire

protocol URLDirectable {
    var urlString: String { get }
}

protocol HeaderContainable {
    func authorizedUserHeaders() -> HTTPHeaders?
}

enum APIResult<Value, Error: Swift.Error> {
    case success(_ result: Value)
    case failure(_ error: Error)
}

struct API: HeaderContainable {
    
    //MARK:- Properties
    var method: HTTPMethod
    var endPoint: Endpoint
    var isAuthorized: Bool
    var parameters: [String: Any]?
    var encoding: ParameterEncoding
    var additionalHeaders: HTTPHeaders?

    //MARK:- Life Cycle
    init(method: HTTPMethod, endPoint: Endpoint, isAuthorized: Bool, parameters: [String: Any]? = nil, additionalHeaders: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default) {
     
        self.method = method
        self.endPoint = endPoint
        self.parameters = parameters
        self.isAuthorized = isAuthorized
        self.additionalHeaders = additionalHeaders
        self.encoding = encoding
    }
    
    func authorizedUserHeaders() -> HTTPHeaders? {
        var allHeaders = HTTPHeaders()
        if let additionalHeaders = self.additionalHeaders {
            additionalHeaders.dictionary.forEach { (key,value) in
                allHeaders.add(name: key, value: value)
            }
        }

        //  Append any authorised tokens here

        return allHeaders
    }
}
