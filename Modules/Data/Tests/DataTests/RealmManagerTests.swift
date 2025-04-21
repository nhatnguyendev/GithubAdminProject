//
//  RealmManagerTests.swift
//  Data
//
//  Created by Nhat Nguyen on 21/4/25.
//

import XCTest
import RealmSwift
@testable import Data

final class RealmManagerTests: XCTestCase {

    var realmManager: RealmManager!

    override func setUp() {
        super.setUp()
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realmManager = RealmManager(configuration: config)
    }
    
    override func tearDown() {
        super.tearDown()
        realmManager = nil
    }

    func test_write_singleObject() throws {
        let name = "test_user"
        let user = RealmUser()
        user.login = name
        try realmManager.write(user)

        let results = realmManager.get(RealmUser.self)
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.login, name)
    }

    func test_write_MultipleObjects() throws {
        let user1 = RealmUser()
        user1.login = "a"
        let user2 = RealmUser()
        user2.login = "b"
        try realmManager.write([user1, user2])

        let results = realmManager.get(RealmUser.self)
        XCTAssertEqual(results.count, 2)
    }
}
