//
//  UserViewModel.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import UIKit

class UserViewModel {
    var user: User!
    var image: UIImage!
    
    init(user: User) {
        self.user = user
    }
    
    func loadUserImage(completion: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.global().async {
            if let image = self.image {
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            }
            guard let url = URL(string: self.user.picture.large) else { return }
            do {
                let img =  try UIImage(data: Data(contentsOf: url))
                self.image = img
                DispatchQueue.main.async {
                    completion(img!)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
