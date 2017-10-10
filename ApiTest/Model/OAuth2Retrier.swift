//
//  OAuth2Retrier.swift
//  ApiTest
//
// The OAuth2Retrier type is responsible for refreshing access tokens
//  Created by Herman Sadik on 05/10/2017.
//  Copyright © 2017 Herman Sadik. All rights reserved.
//

import Foundation
import Alamofire

private class OAuth2Retrier: Alamofire.RequestRetrier {
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if (error as? AFError)?.responseCode == 401 {
            // TODO: implement your Auth2 refresh flow
            // See https://github.com/Alamofire/Alamofire#adapting-and-retrying-requests
        }
        completion(false, 0)
    }
}
