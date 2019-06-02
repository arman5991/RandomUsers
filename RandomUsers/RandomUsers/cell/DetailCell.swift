//
//  DetailCell.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/28/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
   @IBOutlet var gender: UILabel!
   @IBOutlet var title: UILabel!
   @IBOutlet var first: UILabel!
   @IBOutlet var last: UILabel!
   @IBOutlet var email: UILabel!
   @IBOutlet var phone: UILabel!
   @IBOutlet var call: UILabel!
   @IBOutlet var street: UILabel!
   @IBOutlet var city: UILabel!
   @IBOutlet var state: UILabel!
   @IBOutlet var latitude: UILabel!
   @IBOutlet var longitude: UILabel!
   @IBOutlet var timezoneOffset: UILabel!
   @IBOutlet var timezoneDescription: UILabel!
   @IBOutlet var uuid: UILabel!
   @IBOutlet var username: UILabel!
   @IBOutlet var password: UILabel!
   @IBOutlet var salt: UILabel!
   @IBOutlet var md5: UILabel!
   @IBOutlet var sha1: UILabel!
   @IBOutlet var sha256: UILabel!
   @IBOutlet var registeredDate: UILabel!
   @IBOutlet var registeredAge: UILabel!
   @IBOutlet var dobDate: UILabel!
   @IBOutlet var dobAge: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
