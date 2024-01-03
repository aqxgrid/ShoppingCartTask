//
//  ResponseModel.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 02/01/2024.
//

import Foundation

struct CartResponseData: Decodable {
    var data: DataInfo?
}

struct DataInfo : Decodable {
    var cart: Cart?
    var recommended_products: Product?
}

struct Cart : Decodable {
    var products: [CartProduct]?
}

struct CartProduct: Decodable {
    var name: String?
    var price_formatted: String?
    var total: String?
    var thumb: String?
    var manufacturer_name: String?
    var total_formatted: String?
}

struct Product : Decodable {
    var products: [RecommendedProducts]?
}

struct RecommendedProducts: Decodable {

    var name: String?
    var description: String?
    var price_formated: String?
    var thumb: String?
}
