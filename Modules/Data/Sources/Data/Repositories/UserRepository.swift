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
    
    public init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    public func fetchUsers(since: Int) -> AnyPublisher<[UserEntity], any Error> {
        return apiService.request(
            endpoint: GetUsersEndpoint(since: since),
            responseType: [UserDTO].self
        ).map {
            $0.map {
                $0.toDomain()
            }
        }.eraseToAnyPublisher()
    }
    
    public func fetchUserDetail(id: String) -> AnyPublisher<UserEntity, any Error> {
        return Just(
            UserEntity.mock
        ).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
