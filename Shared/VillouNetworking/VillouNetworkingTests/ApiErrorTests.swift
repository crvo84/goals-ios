//
//  ApiErrorTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 27/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import XCTest
@testable import VillouNetworking

class ApiErrorTests: XCTestCase {
}

// MARK: - Tests
extension ApiErrorTests {

    // MARK: asApiError

    func testAsApiError_ActualApiError_ShouldNotReturnNil() {
        // given
        let error = ApiError.invalidRequest(nil) as Error

        // then
        XCTAssertNotNil(error.asApiError)
    }

    func testAsApiError_NotAnApiError_ShouldReturnNil() {
        // given
        let error = TestError.any as Error

        // then
        XCTAssertNil(error.asApiError)
    }

    // MARK: isInvalidRequest

    func testIsInvalidRequest() {
        XCTAssertFalse(ApiError.unknown.isInvalidRequest)
        XCTAssertTrue(ApiError.invalidRequest(nil).isInvalidRequest)
    }

    // MARK: isInvalidResponse

    func testIsInvalidResponse() {
        XCTAssertFalse(ApiError.unknown.isInvalidResponse)
        XCTAssertTrue(ApiError.invalidResponse(nil).isInvalidResponse)
    }

    // MARK: isResponse

    func testIsResponse() {
        XCTAssertFalse(ApiError.unknown.isResponse)
        XCTAssertTrue(ApiError.response(nil, statusCode: 200, data: nil).isResponse)
    }

    // MARK: isDecoding

    func testIsDecoding() {
        XCTAssertFalse(ApiError.unknown.isDecoding)
        XCTAssertTrue(ApiError.decoding(nil).isDecoding)
    }

    // MARK: isUnknown

    func testIsUnknown() {
        XCTAssertFalse(ApiError.invalidRequest(nil).isUnknown)
        XCTAssertTrue(ApiError.unknown.isUnknown)
    }
}
