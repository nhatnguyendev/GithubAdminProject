//
//  UserDetailsViewModelTests.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import XCTest
import Combine
import Domain
@testable import Presentation

final class MockUserDetailsUseCase: UserDetailUseCaseProtocol {
    
    var mockUser: UserEntity = .mock
    var shouldError: Bool = false
    
    func getUserDetail(loginUserName: String) -> AnyPublisher<Domain.UserEntity, any Error> {
        if shouldError {
            return Fail(error: URLError(.timedOut))
                        .eraseToAnyPublisher()
        }
        return Just(mockUser)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class UserDetailsViewModelTests: XCTestCase {
    
    var viewModel: UserDetailViewModel!
    var mockUseCase: MockUserDetailsUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockUseCase = MockUserDetailsUseCase()
        viewModel = UserDetailViewModel(
            loginUserName: "lukesutton",
            userDetailUseCase: mockUseCase
        )
        cancellables = []
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_getUserDetails_success() {
        let expectation = expectation(description: "Load user details successfully")
        viewModel.$user
            .dropFirst()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Test failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { user in
                if user != nil {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.getUserDetail()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.name, viewModel.loginUserName)
        XCTAssertEqual(viewModel.blog, "http://souja.net")
        XCTAssertEqual(viewModel.noOfFollowers, 50)
        XCTAssertEqual(viewModel.noOfFollowing, 100)
    }
    
    func test_getUserDetails_setsErrorAndErrorMessage() {
        mockUseCase.shouldError = true
        let expectation = expectation(description: "Load user should fail and emit error")
        viewModel.$showErrorAlert
            .dropFirst()
            .sink { showAlert in
                if showAlert {
                    XCTAssertEqual(self.viewModel.errorMessage, URLError(.timedOut).localizedDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getUserDetail()
        wait(for: [expectation], timeout: 1)
    }
}
