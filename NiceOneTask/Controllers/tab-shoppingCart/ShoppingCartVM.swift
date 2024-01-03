//
//  ShoppingCartViewModel.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/30/23.
//

import Foundation

protocol ShoppingCartVMDelegate: AnyObject {
    // To be used for backward communication with controller.
}

class ShoppingCartVM {

    weak var delegate: ShoppingCartVMDelegate?
    var cartResponse: CartResponseData?
    init() {
        fetchShoppingCartData()
    }

    private func fetchShoppingCartData() {
       if let url = Bundle.main.url(forResource: "CartResponse", withExtension: "json") {
           do {
               let data = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               self.cartResponse = try decoder.decode(CartResponseData.self, from: data)
           } catch {
               print("error:\(error)")
           }
       }
   }
}
