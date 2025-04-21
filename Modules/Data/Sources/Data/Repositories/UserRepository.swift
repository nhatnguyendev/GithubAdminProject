//
//  UserRepository.swift
//  Data
//
//  Created by Nhat Nguyen on 19/4/25.
//
import Domain
import Combine

public final class UserRepository: UserRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let localDataSource: UserLocalDataSourceProtocol
    
    public init(
        apiService: APIServiceProtocol,
        localDataSource: UserLocalDataSourceProtocol
    ) {
        self.apiService = apiService
        self.localDataSource = localDataSource
    }
    
    public func fetchUsers(perPage: Int, since: Int) -> AnyPublisher<[UserEntity], any Error> {
        return apiService.request(
            GetUsersRequest(perPage: perPage, since: since),
            responseType: [UserDTO].self
        ).map {
            $0.map {
                $0.toDomain()
            }
        }.eraseToAnyPublisher()
    }
    
    public func fetchUserDetail(loginUserName: String) -> AnyPublisher<UserEntity, any Error> {
        return apiService.request(
            GetUserDetailRequest(loginUserName: loginUserName),
            responseType: UserDTO.self
        ).map {
            $0.toDomain()
        }.eraseToAnyPublisher()
    }
    
    public func getCachedUsers() -> [UserEntity] {
        return localDataSource.getCachedUsers().map { $0.toDomain() }
    }
    
    public func cacheUsers(_ users: [UserEntity]) {
        let realmUsers = users.map { $0.toRealmUser() }
        localDataSource.cacheUsers(realmUsers)
    }
}
