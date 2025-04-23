//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 19/4/25.
//

import XCTest
import Combine
@testable import Domain

final class UserListUseCaseTests: XCTestCase {
    
    struct MockPaginationPolicy: PaginationPolicy {
        var itemsPerPage: Int = 2
    }
    
    var mockUserRepository: MockUserRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockUserRepository = MockUserRepository()
        cancellables = []
    }
    
    override func tearDown() {
        mockUserRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_getUsers_success() {
        let expectation = self.expectation(description: "Get users successfully")
        
        let userListUseCase = UsersListUseCase(
            paginationPolicy: MockPaginationPolicy(),
            userRepository: mockUserRepository
        )
        userListUseCase.getUsers(since: 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { users in
                XCTAssertEqual(userListUseCase.paginationPolicy.itemsPerPage, 2)
                XCTAssertEqual(users.count, 2)
                let firstUser = users.first
                XCTAssertEqual(firstUser?.login, "lukesutton")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getUsers_and_cacheUsers_success() {
        let expectation = self.expectation(description: "Get users and cache successfully since 0")
        
        let userListUseCase = UsersListUseCase(
            paginationPolicy: MockPaginationPolicy(),
            userRepository: mockUserRepository
        )
        userListUseCase.getUsers(since: 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { [weak self] users in
                guard let self else { return }
                XCTAssertEqual(self.mockUserRepository.cachedUsers.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
