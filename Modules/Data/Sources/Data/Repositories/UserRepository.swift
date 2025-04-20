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
}
