//
//  PlaceModel.swift
//  Nearby
//
//  Created by Mateus Henrique Coelho de Paulo on 12/11/24.
//

import Foundation

struct Place: Decodable {
    let id: String
    let name: String
    let description: String
    let coupons: Int
    let latitude: Double
    let longitude: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String
}
