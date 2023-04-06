//
//  Service.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 06.04.2023.
//

import Foundation

protocol ServiceProtocol {
    func requestCategory(complition: @escaping (Data?, Error?) -> ())
    func requestProducts(complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func requestCategory(complition: @escaping (Data?, Error?) -> ()) {
        let url = url(urlPath: .allCategory)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
    }
    
    func requestProducts(complition: @escaping (Data?, Error?) -> ()) {
        let url = url(urlPath: .allProducts)
        var urlRequest = URLRequest(url: url)
//        let headers = [ "Content-Type": "application/json" ]
        urlRequest.httpMethod = "get"
//        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param)
//        urlRequest.allHTTPHeaderFields = headers
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
    
    private enum UrlPath {
        case allProducts, allCategory
    }
    
    private func url(urlPath: UrlPath) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "fakestoreapi.com"
        
        switch urlPath {
        case .allCategory:
            components.path = "/products/categories"
        case .allProducts:
            components.path = "/products"
        }
        
        return components.url!
    }
}
