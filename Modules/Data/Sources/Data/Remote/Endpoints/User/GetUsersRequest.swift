//
//  File.swift
//  Data
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

struct GetUsersRequest: BaseRequest {
    
    var perPage: Int
    var since: Int
    
    var path: String {
        return "https://api.github.com/users"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "since", value: "\(since)")
        ]
    }
}
