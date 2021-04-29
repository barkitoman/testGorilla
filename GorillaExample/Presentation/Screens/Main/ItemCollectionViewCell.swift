//
//  ItemCollectionViewCell.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contenImage: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contrainWith: NSLayoutConstraint!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var labelCount: UILabel!
    
    static let identifier = "ItemCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.content.layer.borderWidth = 2
        self.viewCount.isHidden = false
        self.content.layer.borderColor = UIColor(hexString: "#8e8e8e").cgColor
        self.content.layer.cornerRadius = 5
        self.contenImage.layer.cornerRadius = self.contenImage.frame.height/2
        self.viewCount.layer.cornerRadius = 15
    }
    
    public func configure(with image: UIImage, price: String, color:UIColor, name: String, width: CGFloat, numItems: Int){
        self.imageView.image = image
        self.imageView.backgroundColor = color
        self.contenImage.backgroundColor = color
        self.price.text = price
        self.name.text = name
        self.contrainWith.constant = width
        if numItems > 0 {
            self.viewCount.isHidden = false
            self.labelCount.text = String(numItems)
            self.content.layer.borderColor = UIColor(hexString: "#91D8DC").cgColor
        }else{
            self.viewCount.isHidden = true
            self.content.layer.borderColor = UIColor(hexString: "#8e8e8e").cgColor
        }
        
    }
    
    static func nib()  -> UINib {
        return UINib(nibName: "ItemCollectionViewCell", bundle: nil)
    }

}
