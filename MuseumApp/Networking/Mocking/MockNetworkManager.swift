//
//  MockNetworkManager.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation
import Alamofire

protocol LocalJsonFileReadable {
    func getData(jsonFileName: String) -> Data?
}

extension LocalJsonFileReadable {
    func getData(jsonFileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        }
        return nil
    }
}

class MockNetworkManager: Requestable, LocalJsonFileReadable {
    static let shared = MockNetworkManager()
    private init() {}
    static var baseURL: String { return "Mocking" }
    func request(api: API, result: @escaping APIResultType) -> DataRequest? {
        let jsonFileName = api.endPoint.mockFileName
        if let data = getData(jsonFileName: jsonFileName) {
            result(.success(data))
        }
        else {
            result(.failure(MAError.jsonFileMissing(jsonFileName)))
        }
        return nil
    }
}
