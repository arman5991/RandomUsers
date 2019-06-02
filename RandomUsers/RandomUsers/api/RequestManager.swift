//
//  RequestManager.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    class func getUsersWithCount(_ count: Int,
                                 success:@escaping (_ user: [User]) -> (),
                                 failure:@escaping (Error) -> ()) {
        
        let url = baseURL + "\(count)"
        Alamofire.request(url).response { response in
            if response.error == nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(Users.self, from: response.data!)
                    success(result.results)
                } catch let err {
                    failure(err)
                    print(err.localizedDescription)
                }
            } else {
                print(response.error.debugDescription)
                failure(response.error!)
            }
        }
    }
}
