//
//  UsersListView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import SwiftUI
import Domain
import Data

public struct UsersListView: View {
    
    @StateObject private var viewModel: UsersListViewModel
    
    public init(viewModel: UsersListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        List(viewModel.users) { user in
            UserListItemView(
                avatar: URL(string: user.avatarURL)!,
                name: user.login,
                link: user.htmlURL
            )
            .zeroListPadding()
            .listRowSeparator(.hidden)
            .onAppear {
                if viewModel.isLastItem(user) {
                    viewModel.getUsers(isInitial: false)
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            if viewModel.users.isEmpty {
                viewModel.getUsers()
            }
        }
    }
}

#Preview {
    UsersListView(
        viewModel: .init(
            usersListUseCase: UsersListUseCase(
                userRepository: UserRepository(
                    apiService: APIService()
                )
            )
        )
    )
}
