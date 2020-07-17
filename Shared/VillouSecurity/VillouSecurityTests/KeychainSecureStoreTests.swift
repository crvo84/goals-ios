//
//  KeychainSecureStoreTests.swift
//  VillouSecureStoreTests
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import XCTest
@testable import VillouSecurity

class KeychainSecureStoreTests: XCTestCase {

    enum TestError: Error {
        case precondition
    }

    struct MyStruct: Codable {
        let str: String
    }

    var sut: KeychainSecureStore!

    override func setUpWithError() throws {
        sut = KeychainSecureStore()
    }

    override func tearDownWithError() throws {
        try sut.deleteAllSecureStore()
    }
}

// MARK: - Tests
extension KeychainSecureStoreTests {

    // MARK: Save

    func testSave_ValueExists_ShouldUpdateValue() throws {
        // given
        let key = "key1357"
        let directory = "directory9753"
        let oldValue = MyStruct(str: "value3157")
        try sut.save(oldValue, directory: directory, key: key)

        // when
        let newValue = MyStruct(str: "value1122")
        try sut.save(newValue, directory: directory, key: key)

        // then
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        XCTAssertEqual(newValue.str, retrieved?.str)
    }

    func testSave_ValueDoesNotExist_ShouldCreateValue() throws {
        // given
        let key = "key7654"
        let directory = "directory3333"
        let value = MyStruct(str: "value4321")
        let previous = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        guard previous == nil else { throw TestError.precondition }

        // when
        try sut.save(value, directory: directory, key: key)

        // then
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        XCTAssertEqual(value.str, retrieved?.str)
    }

    // MARK: Retrieve

    func testRetrieve_ValueExists_ShouldReturnValue() throws {
        // given
        let key = "key9876"
        let directory = "directory8765"
        let value = MyStruct(str: "value1234")
        try sut.save(value, directory: directory, key: key)

        // when
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)

        // then
        XCTAssertEqual(value.str, retrieved?.str)
    }

    func testRetrieve_ValueDoesNotExists_ShouldReturnNil() throws {
        // given
        let key = "key1111"
        let directory = "directory8888"

        // when
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)

        // then
        XCTAssertNil(retrieved)
    }

    // MARK: Delete

    func testDelete_ValueExists_ShouldDeleteValue() throws {
        // given
        let key = "key2112"
        let directory = "directory9779"
        let value = MyStruct(str: "value6556")
        try sut.save(value, directory: directory, key: key)
        let previous = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        guard previous != nil else { throw TestError.precondition }

        // when
        try sut.delete(directory: directory, key: key)

        // then
        let retrieved = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        XCTAssertNil(retrieved)
    }

    func testDelete_ValueDoesNotExists_ShouldDoNothing() throws {
        // given
        let key = "key3331"
        let directory = "directory7772"
        let previous = try sut.retrieve(MyStruct.self, directory: directory, key: key)
        guard previous == nil else { throw TestError.precondition }

        // when
        try sut.delete(directory: directory, key: key)

        // then, should not throw error
    }

    // MARK: Delete All

    func testDeleteAll_ValuesExistInDirectory_ShouldDeleteAllValuesInDirectory() throws {
        // given
        // FIRST directory
        let directoryA = "directory8889"

        let keyA1 = "key1119"
        let valueA1 = MyStruct(str: "value1212")
        try sut.save(valueA1, directory: directoryA, key: keyA1)

        let keyA2 = "key2229"
        let valueA2 = MyStruct(str: "value9898")
        try sut.save(valueA2, directory: directoryA, key: keyA2)

        // SECOND directory
        let directoryB = "directory7666"

        let keyB = "key8777"
        let valueB = MyStruct(str: "value5454")
        try sut.save(valueB, directory: directoryB, key: keyB)

        let existingA1 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA1)
        let existingA2 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA2)
        let existingB = try sut.retrieve(MyStruct.self, directory: directoryB, key: keyB)

        guard existingA1 != nil, existingA2 != nil, existingB != nil else { throw TestError.precondition }

        // when
        try sut.deleteAll(directory: directoryA)

        // then
        let retrievedA1 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA1)
        let retrievedA2 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA2)
        let retrievedB = try sut.retrieve(MyStruct.self, directory: directoryB, key: keyB)
        XCTAssertNil(retrievedA1)
        XCTAssertNil(retrievedA2)
        XCTAssertEqual(valueB.str, retrievedB?.str)
    }

    func testDeleteAll_ValuesDoNotExistInDirectory_ShouldDoNothing() throws {
        // when
        try sut.deleteAll(directory: "directory5433")

        // then, should not throw error
    }

    // MARK: Delete All Secure Store

    func testDeleteAllSecureStore_ValuesExistInDifferentDirectories_ShouldDeleteAllValuesInAllDirectories() throws {
        // given
        // FIRST directory
        let directoryA = "directory1470"

        let keyA1 = "key2581"
        let valueA1 = MyStruct(str: "value3692")
        try sut.save(valueA1, directory: directoryA, key: keyA1)

        let keyA2 = "key4703"
        let valueA2 = MyStruct(str: "value5814")
        try sut.save(valueA2, directory: directoryA, key: keyA2)

        // SECOND directory
        let directoryB = "directory6925"

        let keyB = "key7036"
        let valueB = MyStruct(str: "value8147")
        try sut.save(valueB, directory: directoryB, key: keyB)

        let existingA1 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA1)
        let existingA2 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA2)
        let existingB = try sut.retrieve(MyStruct.self, directory: directoryB, key: keyB)

        guard existingA1 != nil, existingA2 != nil, existingB != nil else { throw TestError.precondition }

        // when
        try sut.deleteAllSecureStore()

        // then
        let retrievedA1 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA1)
        let retrievedA2 = try sut.retrieve(MyStruct.self, directory: directoryA, key: keyA2)
        let retrievedB = try sut.retrieve(MyStruct.self, directory: directoryB, key: keyB)
        XCTAssertNil(retrievedA1)
        XCTAssertNil(retrievedA2)
        XCTAssertNil(retrievedB)
    }

    func testDeleteAllSecureStore_ValuesDoNotExistInAnyDirectory_ShouldDoNothing() throws {
        // when
        try sut.deleteAllSecureStore()

        // then, should not throw error
    }
}
