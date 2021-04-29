//
//  ViewController.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import UIKit
import Combine

class ViewController: BaseViewController {

    @IBOutlet weak var labelButton: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var viewButton: UIView!
    
    var listItems: [ProductsModel] = []
    var itemsSelect: [ProductsModel] = []
    
    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    var cancelables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.bind()
        self.renderScreen()
        
    }
    
    func renderScreen () {
        self.labelButton.text = "ORDER"
        self.viewButton.layer.opacity = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.renderScreen()
        self.viewModel.action.send(.initial)
    }
    
    func bind() {
        self.cancelables = [
            viewModel.state
                .sink(receiveValue: {[unowned self] state in
                self.render(state)
            })
        ]
    }
    
    func setSelectionItems(){
        self.itemsSelect = self.listItems.filter { $0.numberProductos>0
            
        }
        if self.itemsSelect.count > 0 {
            self.labelButton.text = "ORDER \(itemsSelect.count) ITEMS"
            self.viewButton.layer.opacity = 1
        }else{
            self.labelButton.text = "ORDER"
            self.viewButton.layer.opacity = 0.5
        }
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
        listItems = products
        DispatchQueue.main.async {
            self.collectionView.reloadData();
        }
    }
    @IBAction func goToOrder(_ sender: Any) {
        if(self.itemsSelect.count>0){
            let vc = DetailOrderViewController().instantiateViewController() as! DetailOrderViewController
             vc.itemsSelect = self.itemsSelect
            self.navigateToControllerInStoryboard(controller: vc,isFullScreen: true)
        }
    }
    
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        if self.listItems[indexPath.row].numberProductos == 2 {
            self.listItems[indexPath.row].numberProductos = 0
        }else {
            self.listItems[indexPath.row].numberProductos += 1
        }
        
        let item = self.listItems[indexPath.row]
        DispatchQueue.main.async {
            cell.configure(with: (UIImage(named: item.type ?? "froyo") ??  UIImage(named: "froyo"))!  , price: item.price ?? "", color: UIColor(hexString: item.bg_color ?? ""), name: item.name1 ?? "" , width: self.view.frame.width/2, numItems: item.numberProductos)
            collectionView.reloadItems(at: [ indexPath ]  )
            self.setSelectionItems()
        }
        
        
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listItems.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        let item = listItems[indexPath.row]
        
        cell.configure(with: (UIImage(named: item.type ?? "froyo") ??  UIImage(named: "froyo"))!  , price: item.price ?? "", color: UIColor(hexString: item.bg_color ?? ""), name: item.name1 ?? "" , width: self.view.frame.width/2, numItems: item.numberProductos)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:227)
    }
    
    
}
