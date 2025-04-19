//
//  Router+handleNavigation.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import SwiftUI

public extension Router {
    
    @MainActor
    @ViewBuilder
    func handleNavigation(for destination: Destination) -> some View {
        switch destination {
        case .userDetail(let id):
            Text("User: \(id)")
        }
    }
}
