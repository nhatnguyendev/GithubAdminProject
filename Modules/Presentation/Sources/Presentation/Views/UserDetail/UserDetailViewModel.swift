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
    
    @Published private(set) var user: UserEntity?
    
    @Published private(set) var errorMessage: String = ""
    @Published var showErrorAlert: Bool = false
    
    var avatar: URL? {
        return URL(string: user?.avatarURL ?? "")
    }
    
    var name: String {
        return user?.login ?? ""
    }
    
    var location: String {
        return user?.location ?? ""
    }
    
    var noOfFollowers: Int {
        return user?.followers ?? 0
    }
    
    var noOfFollowing: Int {
        return user?.following ?? 0
    }
    
    var blog: String {
        return user?.blog ?? ""
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let userDetailUseCase: UserDetailUseCaseProtocol
    let loginUserName: String
    
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
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.showErrorAlert = true
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
