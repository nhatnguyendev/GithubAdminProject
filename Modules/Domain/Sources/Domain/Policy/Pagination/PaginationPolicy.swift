//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

public protocol PaginationPolicy {
    var itemsPerPage: Int { get }
}

public struct DefaultPaginationPolicy: PaginationPolicy {
    public init() { }
    public let itemsPerPage: Int = 20
}
