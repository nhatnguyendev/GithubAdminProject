//
//  File.swift
//  Domain
//
//  Created by Nhat Nguyen on 20/4/25.
//

import XCTest
import Combine
@testable import Domain

final class UserDetailUseCaseTests: XCTestCase {
    
    var mockUserRepository: MockUserRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockUserRepository = MockUserRepository()
        cancellables = []
    }
    
    override func tearDown() {
        mockUserRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_getUserDetail_success() {
        let expectation = self.expectation(description: "Get user details successfully")
        let loginUserName = "lukesutton"
        let userDetailUseCase = UserDetailUseCase(userRepository: mockUserRepository)
        userDetailUseCase.getUserDetail(loginUserName: loginUserName)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { user in
                XCTAssertEqual(user.login, loginUserName)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }
}
