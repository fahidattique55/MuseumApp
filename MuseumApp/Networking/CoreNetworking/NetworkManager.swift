//
//  NetworkManager.swift
//  MuseumApp
//
//  Created by fahid on 12/12/2021.
//

import Foundation
import Alamofire

typealias APIResultType = (APIResult<Data,Error>) -> Void

protocol Requestable {
    var baseURL: String { get }
    func request(api: API, result: @escaping APIResultType) -> DataRequest?
}

class NetworkManager: Requestable {
    
    var baseURL: String {
      return "https://collectionapi.metmuseum.org/public/collection/v1"
    }
    
    func request(api: API, result: @escaping APIResultType) -> DataRequest? {
        let request = AF.request(api.endPoint.urlString, method: api.method, parameters: api.parameters, encoding: api.encoding, headers: api.authorizedUserHeaders())
        request.responseData { response in
            switch response.result {
            case .success(let data):
                result(.success(data))
                break
            case .failure(let error):
                result(.failure(error))
            }
        }
        
        request.responseString { response in
            print("❤️💚❤️")
            print("URL:")
            print(api.endPoint.urlString)
            print("Params:")
            print(api.parameters ?? "No Parameters")
            print("Response:")
            print(response)
            print("❤️💚❤️")
        }
        return request
    }
}
