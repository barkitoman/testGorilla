//
//  DetailOrderViewController.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import UIKit

class DetailOrderViewController: UIViewController {

    var itemsSelect: [ProductsModel] = []
    
    @IBOutlet weak var backToOrder: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backToOrder.layer.borderWidth = 1
        self.backToOrder.layer.borderColor = UIColor(hexString: "#117D81").cgColor
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    @IBAction func goToOrder(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
