//
//  MockNetworkingManagerTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 27/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxBlocking
import RxSwift
import XCTest
@testable import VillouNetworking

class MockNetworkingManagerTests: XCTestCase {

    // mocks
    private var request: ApiRequestMock!

    // sut
    private var sut: MockNetworkingManager!

    // rx scheduler
    private var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()

        request = ApiRequestMock()
        sut = MockNetworkingManager(waitDuration: 0.0)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        sut = nil
        request = nil
        scheduler = nil

        super.tearDown()
    }
}

// MARK: Tests
extension MockNetworkingManagerTests {

    // MARK: executeRequest

    func testExecuteRequest_NoMockResponse_ReturnInvalidRequestError() {
        // given
        request.mockResponse = nil

        // when
        let single = sut.execute(request: request)
        let singleResult = single.subscribeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case let .failed(_, error):
            XCTAssertEqual(true, error.asApiError?.isInvalidRequest)
        case .completed:
            XCTFail("Single should fail")
        }
    }

    func testExecuteRequest_InvalidStatusCode_ReturnResponseError() {
        let testData = "some mock data".data(using: .utf8)

        for statusCode in [199, 300, 404] {
            // given
            request.mockResponse = (statusCode, testData, TestError.any)

            // when
            let single = sut.execute(request: request)
            let singleResult = single.subscribeOn(scheduler).toBlocking().materialize()

            // then
            switch singleResult {
            case let .failed(_, error):
                if case let .response(underlyingError, errorStatusCode, errorData) = error.asApiError {
                    XCTAssertEqual(.any, underlyingError as? TestError)
                    XCTAssertEqual(statusCode, errorStatusCode)
                    XCTAssertEqual(testData, errorData)
                } else {
                    XCTFail("Incorrect Single result error")
                }
            case .completed:
                XCTFail("Single should fail for status code: \(statusCode)")
            }
        }
    }

    func testExecuteRequest_ValidResponse_ReturnData() {
        for statusCode in [200, 299] {
            // given
            let testData = "Some test string".data(using: .utf8)
            request.mockResponse = (statusCode, testData, TestError.any)

            // when
            let single = sut.execute(request: request)
            let singleResult = single.observeOn(scheduler).toBlocking().materialize()

            // then
            switch singleResult {
            case let .completed(elements):
                XCTAssertEqual(testData, elements.first)
            case .failed:
                XCTFail("Single should complete successfully")
            }
        }
    }
}


