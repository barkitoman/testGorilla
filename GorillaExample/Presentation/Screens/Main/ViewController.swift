//
//  ViewController.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import UIKit
import Combine

class ViewController: BaseViewController {

    @IBOutlet var collectionView: UICollectionView!
    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    var cancelables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    func bind() {
        self.cancelables = [
            viewModel.state
                .sink(receiveValue: {[unowned self] state in
                self.render(state)
            })
        ]
    }
    
    private func render(_ state: MainViewModel.State) {
        switch state {
        case .initial:
            viewModel.action.send(.initial)
            break
        case .successListProducs(let result):
            self.renderListCategory(result)
        case .failed(error: let error):
            print(error)
        }
    }
    
    func renderListCategory(_ products: [ProductsModel]) {
       print(products)
    }

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("tap")
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
