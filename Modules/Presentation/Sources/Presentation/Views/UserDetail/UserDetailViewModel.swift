//
//  File.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Foundation
import Domain
import Combine

public final class UserDetailViewModel: ObservableObject {
    
    @Published private(set) var user: UserEntity? = UserEntity.mock // TODO: remove mock
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let userDetailUseCase: UserDetailUseCaseProtocol
    private let loginUserName: String
    
    public init(
        loginUserName: String,
        userDetailUseCase: UserDetailUseCaseProtocol
    ) {
        self.loginUserName = loginUserName
        self.userDetailUseCase = userDetailUseCase
    }
    
    func getUserDetail() {
        userDetailUseCase.getUserDetail(loginUserName: loginUserName)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Get user detail completion \(completion)")
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
