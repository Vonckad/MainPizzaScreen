//
//  Service.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 06.04.2023.
//

import Foundation

protocol ServiceProtocol {
    func requestProducts(complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func requestProducts(complition: @escaping (Data?, Error?) -> ()) {
        let url = url()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
    
    private func url() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "fakestoreapi.com"
        components.path = "/products"
        return components.url!
    }
}
