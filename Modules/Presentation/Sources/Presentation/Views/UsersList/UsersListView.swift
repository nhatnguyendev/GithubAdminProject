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
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel: UsersListViewModel
    
    public init(viewModel: UsersListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        List {
            ForEach(viewModel.users) { user in
                UserListItemView(
                    avatar: URL(string: user.avatarURL),
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
                .onTapGesture {
                    router.navigate(to: .userDetail(loginUserName: user.login))
                }
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Github Users")
        .navigationBarTitleDisplayMode(.inline)
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
                    apiService: APIService(),
                    localDataSource: UserLocalDataSource(
                        realmManager: RealmManager()
                    )
                )
            )
        )
    )
}
