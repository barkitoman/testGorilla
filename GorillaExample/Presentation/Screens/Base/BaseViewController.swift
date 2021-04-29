//
//  BaseViewController.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.50, green: 0.82, blue: 0.83, alpha: 1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func navigateToControllerInStoryboard(
        controller: UIViewController,
        isFullScreen:Bool = true) {
        
        if isFullScreen {
            controller.modalPresentationStyle = .fullScreen
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
