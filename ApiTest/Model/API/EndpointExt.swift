//
//  EndpointExt.swift
//  ApiTest
//
//  Created by Herman Sadik on 10/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Foundation
import Mapper
import RxCocoa
import RxSwift
import Decodable
import protocol Decodable.Decodable

extension Endpoint where Response: Decodable {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            decode: Response.decode
        )
    }
}

extension Endpoint where Response == Void {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            decode: { _ in () }
        )
    }
}
