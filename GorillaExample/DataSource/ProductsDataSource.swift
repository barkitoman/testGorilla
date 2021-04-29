//
//  ProducstDataSource.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol ProductsDataSource {
    func getProducts() -> Result<[ProductsModel], FactorError>
}
