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
    @Published var isLoading = false
    @Published private var hasMoreData = true
    
    private var currentPage = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let usersListUseCase: UsersListUseCaseProtocol
    
    public init(usersListUseCase: UsersListUseCaseProtocol) {
        self.usersListUseCase = usersListUseCase
    }
    
    func isLastItem(_ user: UserEntity) -> Bool {
        return user.id == users.last?.id
    }
    
    func getUsers(isInitial: Bool = true) {
        
        if isInitial {
            users = []
            currentPage = 0
            hasMoreData = true
        }
        
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
                self.users.append(contentsOf: users)
                self.currentPage += 1
                self.hasMoreData = !users.isEmpty
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
