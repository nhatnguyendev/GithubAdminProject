//
//  MockUserRepository.swift
//  Domain
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Data
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
    
    func fetchUserDetail(loginUserName id: String) -> AnyPublisher<UserEntity, Error> {
        return Just(UserEntity.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
