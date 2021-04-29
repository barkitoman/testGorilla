//
//  MainViewModel.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation
import Combine

final class MainViewModel {
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<UIAction, Never>()
    private var cancelables = Set<AnyCancellable>()
    
    private var productsDataSource: ProductsDataSource
    
    init(productsDataSource: ProductsDataSource = ProductsDataSourceImpl()) {
        self.productsDataSource = productsDataSource
        self.cancelables = [
            action.subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.global())
                .sink(receiveValue: {action in
                    self.processAction(action)
            })
        ]
    }
    
    func processAction(_ action: UIAction) {
        switch action {
        case .initial:
            getProducts()
        }
    }
        
    func getProducts() {
        let response = productsDataSource.getProducts()
        print(response)
        switch response {
        case .success(let result):
            state.value = .successListProducs(result: result)
        case .failure(let error):
            state.value = .failed(error: error.localizedDescription)
        }
    }
}
    
@available(iOS 13.0, *)
extension MainViewModel {
    enum State : Equatable {
        case initial
        case successListProducs(result: [ProductsModel])
        case failed(error: String)
        static public func == (lhs: State, rhs:State) -> Bool {
            switch (lhs, rhs) {
            case let (.successListProducs(result: resultOne), .successListProducs(result: resultSecond)):
                return resultOne.count == resultSecond.count
            case let (.failed(error: errorFirst), .failed(error: errorSecond)):
                return errorFirst == errorSecond
            default:
                return false
            }
        }
    }
    
    enum UIAction {
        case initial
    }
}

