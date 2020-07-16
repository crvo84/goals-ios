//
//  KeychainSecureStoreTests.swift
//  VillouSecureStoreTests
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import XCTest
@testable import VillouSecureStore

class KeychainSecureStoreTests: XCTestCase {

    enum TestError: Error {
        case storeNotEmpty
    }

    struct MyStruct: Codable {
        let value: String
    }

    var sut: KeychainSecureStore!

    override func setUpWithError() throws {
        sut = KeychainSecureStore()
    }

    override func tearDownWithError() throws {
        try sut.deleteAllSecureStore()
    }
}

extension KeychainSecureStoreTests {

    func testSave_ValueExists_ShouldUpdateValue() throws {
        // given
        let key = "key9876"
        let directory = "myDirectory8765"
        let value = MyStruct(value: "myStruct1234")

        // when
        try sut.save(value, directory: directory, key: key)

        // then
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        XCTAssertEqual("myStruct1234", retrieved?.value)
    }

    func testSave_ValueDoesNotExist_ShouldCreateValue() throws {
        // TODO:
    }

    func testRetrieve_ValueExists_ShouldReturnValue() throws {
        // TODO:
    }

    func testRetrieve_ValueDoesNotExists_ShouldReturnNil() throws {
        // TODO:
    }

    func testDelete_ValueExists_ShouldDeleteValue() throws {
        // TODO:
    }

    func testDelete_ValueDoesNotExists_ShouldDoNothing() throws {
        // TODO:
    }

    func testDeleteAll_ValuesExistInDirectory_ShouldDeleteAllValuesInDirectory() throws {
        // TODO:
    }

    func testDeleteAll_ValuesDoNotExistInDirectory_ShouldDoNothing() throws {
        // TODO:
    }

    func testDeleteAllSecureStore_ValuesExistInDifferentDirectories_ShouldDeleteAllValuesInAllDirectories() throws {
        // TODO:
    }

    func testDeleteAllSecureStore_ValuesDoNotExistInAnyDirectory_ShouldDoNothing() throws {
        // TODO:
    }
}
