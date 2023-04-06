//
//  ServiceFetcher.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 06.04.2023.
//

import Foundation

protocol ServiceFetcherProtocol {
    func fetchProducts(data: Data?, complition: @escaping ([NetProductModel]?) -> Void)
}

class ServiceFetcher: ServiceFetcherProtocol {

    var service: ServiceProtocol = Service()
    
    func fetchProducts(data: Data?, complition: @escaping ([NetProductModel]?) -> Void) {
        service.requestProducts() { data, error in
//            if let error = error {
//                print("error request = \(error.localizedDescription )")
//                complition(nil)
//            }
            let decod = self.decodJSON(type: [NetProductModel].self, from: data)
            complition(decod)
        }
    }

    private func decodJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsonError {
            print("jsonError = \(jsonError)")
            return nil
        }
    }
}
