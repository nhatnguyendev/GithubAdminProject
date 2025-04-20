//
//  File.swift
//  Data
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Foundation

struct GetUserDetailRequest: BaseRequest {
    
    let loginUserName: String
    
    var path: String {
        return "/users/\(loginUserName)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        return [
            "login_username": loginUserName
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
