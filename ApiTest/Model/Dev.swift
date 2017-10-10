//
//  Dev.swift
//  ApiTest
//
//  Created by Herman Sadik on 05/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Mapper

struct Dev: Mappable {
    let id: String?
    
    // Implement this initializer
    init(map: Mapper) throws {
        try id = map.from("id")
    }
}
