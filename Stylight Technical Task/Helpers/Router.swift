//
//  Router.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/17/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import Foundation
import Alamofire


enum ServerCompass : String{
    case TESTING = "https://api.stylight.com/rest/",
    STAGING = "STAGING_API",
    PRODUCTION = "PRODUCTION_API"
}


enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
}

let REQUEST_TIMEOUT_INTERVAL = TimeInterval(10 * 1000)
let API_KEY = "C6490912AB3211E680F576304DEC7EB7"

enum Router: URLRequestConvertible {
    static let baseURLString = ServerCompass.TESTING.rawValue
    case listBrands()
    public func asURLRequest() throws -> URLRequest {
        
        let result : (path : String, method : HTTPMethod) = {
            switch self {
            case .listBrands():
                return ("brands?apiKey=\(API_KEY)",.GET)
            }
        }()
        
        let url = URL(string: Router.baseURLString)
        var request = URLRequest(url: (url?.appendingPathComponent(result.path))!)
        print(request)
        request.httpMethod = result.method.rawValue
        request.timeoutInterval = REQUEST_TIMEOUT_INTERVAL
        
        return request
    }
}
