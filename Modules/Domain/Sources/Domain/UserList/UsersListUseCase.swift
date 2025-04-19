//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import Combine

public protocol UsersListUseCaseProtocol {
    func getUsers(since: Int) -> AnyPublisher<[UserEntity], Error>
}

public final class UsersListUseCase: UsersListUseCaseProtocol {
    
    private let userRepository: UserRepositoryProtocol
    
    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    public func getUsers(since: Int) -> AnyPublisher<[UserEntity], any Error> {
        return userRepository.fetchUsers(perPage: 20, since: since)
    }
}
