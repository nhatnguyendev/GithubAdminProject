//
//  RouterProtocol.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import SwiftUI

public protocol RouterProtocol {
    associatedtype Destination = Hashable
    var path: [Destination] { get set }
    func navigate(to destination: Destination)
    func navigateBack()
    func navigateToRoot()
}
