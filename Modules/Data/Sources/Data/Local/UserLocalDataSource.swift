//
//  UserLocalDataSource.swift
//  Data
//
//  Created by Nhat Nguyen on 21/4/25.
//

import Foundation
import RealmSwift

public final class UserLocalDataSource: UserLocalDataSourceProtocol {
    
    private let realmManager: RealmManagerProtocol

    public init(realmManager: RealmManagerProtocol = RealmManager()) {
        self.realmManager = realmManager
    }

    public func getCachedUsers() -> [RealmUser] {
        return realmManager.get(RealmUser.self)
    }

    public func cacheUsers(_ users: [RealmUser]) {
        do {
            try realmManager.write(users)
        } catch {
            print("Failed to cache users: \(error.localizedDescription)")
        }
    }
}
