//
//  ApiDev.swift
//  ApiTest
//
//  Created by Herman Sadik on 05/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Foundation

extension Api {
    /* namespace */ enum Dev {
        private static let path = "anypath/id"
        
        static func get() -> Endpoint<Dev> {
            return Endpoint(path: path)
        }
    }
}
