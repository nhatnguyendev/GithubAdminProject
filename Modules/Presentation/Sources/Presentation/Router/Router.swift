//
//  Router.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

public final class Router: ObservableObject, RouterProtocol {
    
    @Published public var path = [AppDestination]()
    
    public func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    public func navigateBack() {
        path.removeLast()
    }
    
    public func navigateToRoot() {
        path.removeLast(path.count)
    }
}
