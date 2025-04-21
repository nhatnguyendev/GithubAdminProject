//
//  GithubAdminProjectApp.swift
//  GithubAdminProject
//
//  Created by Nhat Nguyen on 19/4/25.
//

import SwiftUI
import Domain
import Data
import Presentation

@main
struct GithubAdminProjectApp: App {
    
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                UsersListView(
                    viewModel: .init(
                        usersListUseCase: UsersListUseCase(
                            userRepository: UserRepository(
                                apiService: APIService(),
                                localDataSource: UserLocalDataSource(
                                    realmManager: RealmManager()
                                )
                            )
                        )
                    )
                )
                .navigationDestination(for: AppDestination.self) { des in
                    router.handleNavigation(for: des)
                }
            }
            .environmentObject(router)
        }
    }
}
