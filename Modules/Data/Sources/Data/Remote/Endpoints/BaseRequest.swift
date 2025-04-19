//
//  Endpoint.swift
//  Data
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol BaseRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    
    var urlRequest: URLRequest? { get }
}

public extension BaseRequest {
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    var urlRequest: URLRequest? {
        
        guard var components = URLComponents(string: path) else { return nil }
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
    
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
    
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                print("Error serializing parameters: \(error)")
                return nil
            }
        }
        
        return request
    }
}
