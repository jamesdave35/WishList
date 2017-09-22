//
//  dismissKeyboard.swift
//  WishList
//
//  Created by James Meli on 3/1/17.
//  Copyright © 2017 James Meli. All rights reserved.
//

import UIKit

extension UITableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


