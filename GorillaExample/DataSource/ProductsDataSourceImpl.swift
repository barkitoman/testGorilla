//
//  ProductsDataImpl.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation
import Combine

struct ProductsDataSourceImpl: ProductsDataSource {
    let networkServices: NetworkServices
    init() {
        networkServices = NetworkServices()
    }
    func getProducts() -> Result<[ProductsModel], FactorError> {
             return networkServices.get(type: [ProductsModel].self, params: [], aditionalPath: "products")
        
    }
    
    
}
