//
//  InfraTests.swift
//  InfraTests
//
//  Created by Márcio Abrantes on 19/06/23.
//

import XCTest
@testable import Infra

final class InfraTests: XCTestCase {
    
    func test_call_api_alamofire_users_list() {
        let alamofire = AlamofireAdapter()
        let request = UserRequest(headers: nil, method: .get, parameters: nil, body: nil)
        request.user = "?page=4"
        let path = request.path
        let exp = expectation(description: "waiting")
        alamofire.fetchUserList(url: path, headers: request.headers) { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)
    }
    
    func test_call_api_alamofire_user() {
        let alamofire = AlamofireAdapter()
        let request = UserRequest(method: .get, parameters: nil, body: nil)
        request.user = "/abrantesmar"
        let path = request.path
        let exp = expectation(description: "waiting")
        alamofire.fetchUser(url: path, headers: request.headers) { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    func test_call_api_alamofire_repository() {
        let alamofire = AlamofireAdapter()
        let request = UserRequest(method: .get, parameters: nil, body: nil)
        request.user = "/abrantesmar/repos"
        let path = request.path
        let exp = expectation(description: "waiting")
        alamofire.fetchUserRepository(url: path, headers: request.headers) { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)
    }
    
    func test_call_use_case_user_list() {
        let useCase = HttpFactories.makeUsersList()
        let exp = expectation(description: "waiting")
        useCase.fetchUsers() { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)
        
    }
    
    func test_call_use_case_user() {
        let useCase = HttpFactories.makeUser()
        let exp = expectation(description: "waiting")
        useCase.fetchUser(userName: "/abrantesMar") { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)
    }
    
    func test_call_use_case_repository() {
        let useCase = HttpFactories.makeRepository()
        let exp = expectation(description: "waiting")
        useCase.fetchRepository(userName: "/abrantesMar") { result in
            switch result {
            case .failure: XCTFail("Failure")
            case .success(let data):
                print(data)
                XCTAssertNotNil(data)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)
    }
}
