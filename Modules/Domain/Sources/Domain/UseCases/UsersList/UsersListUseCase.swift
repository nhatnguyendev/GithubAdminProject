//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import Combine

public protocol UsersListUseCaseProtocol {
    var paginationPolicy: PaginationPolicy { get }
    func getUsers(since: Int) -> AnyPublisher<[UserEntity], Error>
    func getCachedUsers() -> [UserEntity]
    func saveUsers(_ users: [UserEntity])
}

public final class UsersListUseCase: UsersListUseCaseProtocol {
    public var paginationPolicy: PaginationPolicy
    private let userRepository: UserRepositoryProtocol
    
    public init(
        paginationPolicy: PaginationPolicy = DefaultPaginationPolicy(),
        userRepository: UserRepositoryProtocol
    ) {
        self.paginationPolicy = paginationPolicy
        self.userRepository = userRepository
    }
    
    public func getUsers(since: Int) -> AnyPublisher<[UserEntity], any Error> {
        return userRepository.fetchUsers(
            perPage: paginationPolicy.itemsPerPage,
            since: since
        )
    }
    
    public func getCachedUsers() -> [UserEntity] {
        return userRepository.getCachedUsers()
    }
    
    public func saveUsers(_ users: [UserEntity]) {
        return userRepository.cacheUsers(users)
    }
}
