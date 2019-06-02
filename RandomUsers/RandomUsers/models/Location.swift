//
//  Location.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import Foundation

struct Location: Codable {
    var street: String!
    var city: String!
    var state: String!
    var coordinates: Coordinates!
    var timezone: Timezone!
}
