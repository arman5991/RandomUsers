//
//  User.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import Foundation

struct User: Codable {
    var gender: String!
    var name: Name!
    var location: Location!
    var email: String!
    var login: Login!
    var dob: Dob!
    var registered: Registered!
    var phone: String!
    var cell: String!
    var picture: Picture!
}
