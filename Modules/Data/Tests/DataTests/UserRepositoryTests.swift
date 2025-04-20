//
//  File.swift
//  Data
//
//  Created by Nhat Nguyen on 18/4/25.
//

import XCTest
import Combine
@testable import Data

final class UserRepositoryTests: XCTestCase {
    
    var apiService: MockAPIService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        apiService = MockAPIService()
        cancellables = []
    }
    
    override func tearDown() {
        apiService = nil
        cancellables = nil
        super.tearDown()
    }
    
    final class MockAPIService: APIServiceProtocol {
        var shouldError = false
        var mockResponseFilename: String?
        
        func request<T>(_ endpoint: BaseRequest, responseType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable, T : Encodable {
            if shouldError {
                return Fail(error: APIError.httpError(statusCode: 500, message: "Interal Error")).eraseToAnyPublisher()
            } else if let filename = mockResponseFilename, let mockResponse: T = MockDataHelper.loadJSONFile(filename: filename, type: T.self) {
                return Just(mockResponse)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Empty().eraseToAnyPublisher()
            }
        }
    }
    
    func test_fetchUsers_success() {
        
        let expectation = self.expectation(description: "Fetch users successfully")
        
        apiService.mockResponseFilename = "Users"
        
        let userRepository = UserRepository(apiService: apiService)
        userRepository.fetchUsers(perPage: 2, since: 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { users in
                XCTAssertEqual(users.count, 2)
                let firstUser = users.first
                XCTAssertEqual(firstUser?.login, "jvantuyl")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchUsers_failure() {
        let expectation = self.expectation(description: "Fetch users fails")
        
        apiService.mockResponseFilename = "Users"
        apiService.shouldError = true
        
        let userRepository = UserRepository(apiService: apiService)
        userRepository.fetchUsers(perPage: 2, since: 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is APIError, "Expected error to be of type APIError")
                    expectation.fulfill()
                }
            } receiveValue: { users in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchUserDetail_success() {
        let expectation = self.expectation(description: "Fetch user detail successfully")
        let loginUserName = "BrianTheCoder"
        
        apiService.mockResponseFilename = "UserDetail"
        
        let userRepository = UserRepository(apiService: apiService)
        userRepository.fetchUserDetail(loginUserName: loginUserName)
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
    
    func test_fetchUserDetail_failure() {
        let expectation = self.expectation(description: "Fetch user detail fails")
        let loginUserName = "BrianTheCoder"
        
        apiService.mockResponseFilename = "UserDetail"
        apiService.shouldError = true
        
        let userRepository = UserRepository(apiService: apiService)
        userRepository.fetchUserDetail(loginUserName: loginUserName)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is APIError, "Expected error to be of type APIError")
                    expectation.fulfill()
                }
            } receiveValue: { user in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
