//
//  Endpoint.swift
//  ApiTest
//
//  Created by Herman Sadik on 04/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Foundation
import Mapper
import RxCocoa
import RxSwift
import Decodable
import protocol Decodable.Decodable

final class Endpoint<Response> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let decode: (JSON) throws -> Response
    
    init(method: Method = .get,
         path: Path,
         parameters: Parameters? = nil,
         decode: @escaping (JSON) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }
}

typealias Parameters = [String: Any]
typealias Path = String
typealias JSON = Any

enum Method {
    case get, post, put, patch, delete
}


