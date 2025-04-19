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
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let usersListUseCase: UsersListUseCaseProtocol
    
    public init(usersListUseCase: UsersListUseCaseProtocol) {
        self.usersListUseCase = usersListUseCase
    }
    
    func getUsers() {
        usersListUseCase.getUsers(since: 0)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
