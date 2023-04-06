//
//  NetProductModel.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 06.04.2023.
//

import Foundation

struct NetProductModel: Decodable {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
}
