//
//  Router.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

final class Router: ObservableObject, RouterProtocol {
    
    @Published var path = [AppDestination]()
    
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}