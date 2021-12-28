//
//  ObjectsAPIService.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation
import Alamofire

protocol MuseumObjectAPIs {
    func searchObjectIDs(params: [String:Any], result: @escaping (APIResult<[Int], Error>) -> Void)
    func getDetails(objectID: Int, result: @escaping (APIResult<ArtObject, Error>) -> Void)
}

class MuseumObjectsAPIService: MuseumObjectAPIs {

    private var apiManager: Requestable!
    init(manager: Requestable) {
        self.apiManager = manager
    }
    
    func getDetails(objectID: Int, result: @escaping (APIResult<ArtObject, Error>) -> Void) {
        let api = API(method: .get, endPoint: Endpoint.objectDetails(objectID), isAuthorized: false, parameters: nil, additionalHeaders: nil, encoding: URLEncoding.default)
        _ = apiManager.request(api: api) { [weak self] response in
            guard let _ = self else { return }
            switch response {
            case .success(let data):
                if let object = try? JSONDecoder().decode(ArtObject.self, from: data) {
                    result(.success(object))
                }
                else {
                    result(.failure(MAError.invalidJSONResponse))
                }
                break
            case .failure(let error):
                result(.failure(error))
                break
            }
        }
    }
    
    func searchObjectIDs(params: [String : Any], result: @escaping (APIResult<[Int], Error>) -> Void) {
        let api = API(method: .get, endPoint: Endpoint.searchObjects, isAuthorized: false, parameters: params, additionalHeaders: nil, encoding: URLEncoding.default)
        _ = apiManager.request(api: api) { [weak self] response in
            guard let _ = self else { return }
            switch response {
            case .success(let data):
                if let json = data.json, let objectIDs = json["objectIDs"] as? [Int] {
                    result(.success(objectIDs))
                }
                else {
                    result(.failure(MAError.invalidJSONResponse))
                }
                break
            case .failure(let error):
                result(.failure(error))
                break
            }
        }
    }
}
