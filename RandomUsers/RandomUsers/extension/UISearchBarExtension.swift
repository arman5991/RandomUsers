//
//  UISearchBarExtension.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Search", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
        delegate?.searchBarSearchButtonClicked?(self)
    }
    
    @objc func cancelButtonTapped() {
        self.resignFirstResponder()
    }
}
