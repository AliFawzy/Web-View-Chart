//
//  File.swift
//  IOS Test
//
//  Created by aly on 4/1/19.
//  Copyright © 2019 aly. All rights reserved.
//

import Foundation

struct LoginApiGet: Decodable {
    let array: [Any]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let firstString = try container.decode(String.self)
        let firstInt = try container.decode(Int.self)
        array = [firstString, firstInt]
    }
}
