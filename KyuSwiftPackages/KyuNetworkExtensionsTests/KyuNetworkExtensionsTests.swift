//
//  KyuNetworkExtensionsTests.swift
//  KyuNetworkExtensionsTests
//
//  Created by Chayanon Ardkham on 15/1/21.
//

import XCTest
import KyuNetworkExtensions

class KyuNetworkExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSingleUser() {
        
        // Given
        var expectedUser: User?
        let userExpectation = expectation(description: "User")
        
        // When
        AppService.userService().requestObject(type: User.self, nestedAt: "data", route: .getUser(id: "1")) { (user) in
            expectedUser = user
            userExpectation.fulfill()
        } error: { (error) in
            XCTAssert(false)
            userExpectation.fulfill()
        }
        
        // Then
        wait(for: [userExpectation], timeout: 5)
        
        XCTAssert(expectedUser != nil, expectedUser?.toJSONString(prettyPrint: true) ?? "")
    }
    
    func testGetMultipleUsers() {

        // Given
        var expectedUsers: [User]?
        let usersExpectation = expectation(description: "Users")

        // When
        AppService.userService().requestObjects(type: User.self, nestedAt: "data", route: .getUsers) { (users) in
            expectedUsers = users
            usersExpectation.fulfill()
        } error: { (error) in
            XCTAssert(false)
            usersExpectation.fulfill()
        }

        // Then
        wait(for: [usersExpectation], timeout: 5)

        XCTAssert(expectedUsers?.count ?? 0 > 0, expectedUsers?.toJSONString(prettyPrint: true) ?? "")
    }
}
