//
//  File.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import XCTest
import Combine
import Domain
@testable import Presentation

final class MockUsersListUseCase: UsersListUseCaseProtocol {
    var paginationPolicy: PaginationPolicy = DefaultPaginationPolicy()
    
    var mockUsers: [UserEntity] = []
    
    func getUsers(since: Int) -> AnyPublisher<[UserEntity], Error> {
        return Just(mockUsers)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}


final class UsersListViewModelTests: XCTestCase {
    var viewModel: UsersListViewModel!
    var mockUseCase: MockUsersListUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockUseCase = MockUsersListUseCase()
        viewModel = UsersListViewModel(usersListUseCase: mockUseCase)
        cancellables = []
    }
    
    func test_getUsers_firstPage_success() {
        let itemsPerPage = mockUseCase.paginationPolicy.itemsPerPage
        let testUsers = (1...itemsPerPage).map { _ in
            UserEntity.mock
        }
        mockUseCase.mockUsers = testUsers
        let expectation = expectation(description: "Load users successfully")
        viewModel.$users
            .dropFirst()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Test failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] users in
                guard let self else { return }
                if !users.isEmpty {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.getUsers(isInitial: true)
        wait(for: [expectation], timeout: 1)
        
        // Assert after finished call
        XCTAssertEqual(self.viewModel.users.count, itemsPerPage)
        XCTAssertEqual(self.viewModel.currentPage, 1)
        XCTAssertTrue(self.viewModel.hasMoreData)
    }
    
    func test_loadingFlag_isFalseAfterGetUsersCompletes() {
        let itemsPerPage = mockUseCase.paginationPolicy.itemsPerPage
        let testUsers = (1...itemsPerPage).map { _ in
            UserEntity.mock
        }
        mockUseCase.mockUsers = testUsers
        let expectation = expectation(description: "Loading stopped")
        viewModel.$users
            .dropFirst()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Test failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] users in
                guard let self else { return }
                
                if !users.isEmpty {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.getUsers(isInitial: true)
        wait(for: [expectation], timeout: 1)
        
        // Assert after finished call
        XCTAssertFalse(viewModel.isLoading)
    }
}
