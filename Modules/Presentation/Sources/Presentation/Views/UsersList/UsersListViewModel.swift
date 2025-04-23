//
//  File.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import Domain
import Combine

public final class UsersListViewModel: ObservableObject {
    
    @Published private(set) var users: [UserEntity] = []
    @Published private(set) var isLoading = false
    @Published private(set) var hasMoreData = true
    
    private(set) var currentPage = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let usersListUseCase: UsersListUseCaseProtocol
    
    public init(usersListUseCase: UsersListUseCaseProtocol) {
        self.usersListUseCase = usersListUseCase
    }
    
    func isLastItem(_ user: UserEntity) -> Bool {
        return user.id == users.last?.id
    }
    
    func loadUsers() {
        let cachedUsers = usersListUseCase.getCachedUsers()
        if !cachedUsers.isEmpty {
            self.users = cachedUsers
        }
        getMoreUsers()
    }
    
    func getMoreUsers() {
        
        guard !isLoading, hasMoreData else { return }
        
        isLoading = true
        
        let since = currentPage * usersListUseCase.paginationPolicy.itemsPerPage
        
        usersListUseCase.getUsers(since: since)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Failed to load users: \(error)")
                }
            } receiveValue: { [weak self] users in
                guard let self else { return }
                
                if since == 0 {
                    self.users = users
                } else {
                    self.users.append(contentsOf: users)
                }
                
                self.currentPage += 1
                self.hasMoreData = !users.isEmpty
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
