//
//  UserLocalDataSourceProtocol.swift
//  Data
//
//  Created by Nhat Nguyen on 21/4/25.
//

import RealmSwift

public protocol UserLocalDataSourceProtocol {
    func getCachedUsers() -> [RealmUser]
    func cacheUsers(_ users: [RealmUser])
}

