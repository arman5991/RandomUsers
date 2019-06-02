//
//  Login.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import Foundation

struct Login: Codable {
    var uuid: String!
    var username: String!
    var password: String!
    var salt: String!
    var md5: String!
    var sha1: String!
    var sha256: String!
}
