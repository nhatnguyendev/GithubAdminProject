//
//  MockUserRepository.swift
//  Domain
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Domain
import Combine

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
    
    func fetchUserDetail(loginUserName: String) -> AnyPublisher<UserEntity, Error> {
        return Just(UserEntity.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getCachedUsers() -> [Domain.UserEntity] {
        return [
            UserEntity.mock,
            UserEntity.mock,
        ]
    }
    
    func cacheUsers(_ users: [Domain.UserEntity]) {
    
    }
}
