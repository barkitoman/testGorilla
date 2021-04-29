//
//  ViewController+Extensions.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    static func loadFromNib() -> Self {
       func instantiateFromNib<T: UIViewController>() -> T {
           return T.init(nibName: String(describing: T.self), bundle: nil)
       }
       return instantiateFromNib()
    }
    
    func instantiateViewController(_ bundle: Bundle? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: self.className, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: self.className)
        return viewController
    }
    
}
