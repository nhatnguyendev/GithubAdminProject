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
    
    private var cancellables: Set<AnyCancellable> = []
    
    final class MockAPIService: APIServiceProtocol {
        var shouldError = false
        var mockResponseFilename: String?
        
        func request<T>(endpoint: BaseRequest, responseType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable, T : Encodable {
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
    
    func test_fetchUsers() {
        
        let expectation = self.expectation(description: "Fetch users successfully")
        
        let apiService = MockAPIService()
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
        
        let apiService = MockAPIService()
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
}
