//
//  AppDIContainer.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 22/4/25.
//

import Domain
import Data
import Presentation
import SwiftUI

final class AppDIContainer {
    
    static let shared = AppDIContainer()
    private init() {}

    private lazy var apiService: APIServiceProtocol = APIService()
    private lazy var userRepository: UserRepositoryProtocol = UserRepository(apiService: apiService)

    func makeUserDetailView(loginName: String) -> some View {
        let userDetailUseCase = UserDetailUseCase(userRepository: userRepository)
        let userDetailViewModel = UserDetailViewModel(loginUserName: loginName, userDetailUseCase: userDetailUseCase)
        return UserDetailView(viewModel: userDetailViewModel)
    }
    
    func makeUsersListView() -> some View {
        let usersListUseCase = UsersListUseCase(userRepository: userRepository)
        let usersListViewModel = UsersListViewModel(usersListUseCase: usersListUseCase)
        return UsersListView(viewModel: usersListViewModel)
    }
}
