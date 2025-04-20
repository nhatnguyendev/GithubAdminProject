//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import Combine

public protocol UserRepositoryProtocol {
    func fetchUsers(perPage: Int, since: Int) -> AnyPublisher<[UserEntity], Error>
    func fetchUserDetail(loginUserName: String) -> AnyPublisher<UserEntity, Error>
}
