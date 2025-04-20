//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Foundation
import Combine

public protocol UserDetailUseCaseProtocol {
    func getUserDetail(loginUserName: String) -> AnyPublisher<UserEntity, Error>
}

public final class UserDetailUseCase: UserDetailUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    public func getUserDetail(loginUserName: String) -> AnyPublisher<UserEntity, any Error> {
        return userRepository.fetchUserDetail(loginUserName: loginUserName)
    }
}
