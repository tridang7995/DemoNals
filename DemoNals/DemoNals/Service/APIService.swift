//
//  APIService.swift
//  UIKitDemoNals
//
//  Created by Tri Dang on 29/12/2021.
//

import Combine
import Foundation

protocol APIService {
    func requestData<T: Codable>(url: String, parameter: [String: Any]?, typeResponse: T) -> AnyPublisher<APIResult<T>, Never>
}

struct APISession: APIService {
    let urlSession: URLSession
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        urlSession = URLSession(configuration: configuration)
    }

    func requestData<T: Codable>(url: String, parameter: [String: Any]?, typeResponse: T) -> AnyPublisher<APIResult<T>, Never> {
        var url = url
        if let user = parameter?["login"] as? String {
            url.append(contentsOf: "/\(user)")
        }
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .flatMap { dataRespone, response -> AnyPublisher<APIResult<T>, Never> in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        return Just(dataRespone)
                            .decode(type: T.self, decoder: decoder)
                            .map { APIResult.success($0) }
                            .replaceError(with: .failure)
                            .eraseToAnyPublisher()
                    } else {
                        return Just(.failure)
                            .replaceError(with: .failure)
                            .eraseToAnyPublisher()
                    }
                }
                return Just(.failure).eraseToAnyPublisher()
            }
            .replaceError(with: .failure)
            .eraseToAnyPublisher()
    }
}

enum APIResult<T> {
    case success(T)
    case failure
}
