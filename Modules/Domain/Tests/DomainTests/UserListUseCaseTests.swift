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
    
    private var cancellables: Set<AnyCancellable> = []
    
    final class MockUserRepository: UserRepositoryProtocol {
        
        func fetchUsers(perPage: Int, since: Int) -> AnyPublisher<[UserEntity], Error> {
            return Just(
                [
                    UserEntity.mock,
                    UserEntity.mock,
                ]
            )
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        
        func fetchUserDetail(id: String) -> AnyPublisher<UserEntity, Error> {
            return Just(UserEntity.mock)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func test_getUsers_success() {
        let expectation = self.expectation(description: "Get users successfully")
        let mockRepository = MockUserRepository()
        
        let userListUseCase = UsersListUseCase(userRepository: mockRepository)
        userListUseCase.getUsers(since: 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { users in
                XCTAssertEqual(users.count, 2)
                let firstUser = users.first
                XCTAssertEqual(firstUser?.login, "lukesutton")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
