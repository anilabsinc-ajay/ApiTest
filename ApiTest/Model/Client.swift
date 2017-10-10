//
//  Client.swift
//  ApiTest
//
//  Created by Herman Sadik on 05/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift
import Decodable
import Mapper
import protocol Decodable.Decodable


protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

final class Client: ClientProtocol {
    private let manager: Alamofire.SessionManager
    private let retrier: OAuth2Retrier
    private let baseURL = URL(string: "https://my_server.com/")!
    private let queue = DispatchQueue(label: "req")
    
    init(accessToken: String) {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Authorization"] = "Bearer \(accessToken)"
        
        let configuration = URLSessionConfiguration.default
        
        // Add `Auth` header to the default HTTP headers set by `Alamofire`
        configuration.httpAdditionalHeaders = defaultHeaders
        
        self.manager = Alamofire.SessionManager(configuration: configuration)
        self.manager.retrier = OAuth2Retrier()
    }
    
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single<Response>.create { observer in
            let request = self.manager.request(
                self.url(path: endpoint.path),
                method: self.httpMethod(from: endpoint.method),
                parameters: endpoint.parameters
            )
            request
                .validate()
                .responseJSON(queue: self.queue) { response in
                    let object = response.result
                        .flatMap(JSON.init)
                        .flatMap(endpoint.decode)
                    observer(Result(object).toEvent)
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func url(path : String) -> URL {
        return URL(string: path)!
    }
    
    func httpMethod(from : Method) -> HTTPMethod{
        if(from == Method.get){
            return HTTPMethod.get
        } else if(from == Method.post) {
            return HTTPMethod.post
        }else if(from == Method.put) {
            return HTTPMethod.put
        }else if(from == Method.patch) {
            return HTTPMethod.patch
        }else if(from == Method.delete) {
            return HTTPMethod.delete
        }
    }
}

private class OAuth2Retrier: Alamofire.RequestRetrier {
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if (error as? AFError)?.responseCode == 401 {
            // TODO: implement your Auth2 refresh flow
            // See https://github.com/Alamofire/Alamofire#adapting-and-retrying-requests
        }
        completion(false, 0)
    }
}
