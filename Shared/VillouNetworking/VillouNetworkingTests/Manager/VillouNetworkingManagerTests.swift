//
//  VillouNetworkingManagerTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import RxBlocking
import XCTest
@testable import VillouNetworking

class VillouNetworkingManagerTests: XCTestCase {

    // mocks
    private var request: ApiRequestMock!
    private var requestHandler: URLRequestHandlerMock!

    // sut
    private var sut: VillouNetworkingManager!

    // rx scheduler
    private var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()

        request = ApiRequestMock()
        requestHandler = URLRequestHandlerMock()
        sut = VillouNetworkingManager(urlRequestHandler: requestHandler)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        sut = nil
        request = nil
        requestHandler = nil
        scheduler = nil

        super.tearDown()
    }
}

// MARK: Tests
extension VillouNetworkingManagerTests {

    // MARK: executeRequest

    func testExecuteRequest_InvalidURLRequest_ReturnInvalidRequestError() {
        // given
        request.expectedResult.asURLRequest = .failure(.invalidRequest(nil))

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

    func testExecuteRequest_NonHTTPURLResponse_ReturnInvalidResponseError() {
        // given
        let nonHTTPResponse = URLResponse()
        request.expectedResult.asURLRequest = .success(.mock)
        requestHandler.expectedResult.urlResponse = nonHTTPResponse

        // when
        let single = sut.execute(request: request)
        let singleResult = single.subscribeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case let .failed(_, error):
            XCTAssertEqual(true, error.asApiError?.isInvalidResponse)
        case .completed:
            XCTFail("Single should fail")
        }
    }

    func testExecuteRequest_InvalidStatusCode_ReturnResponseError() {
        for statusCode in [199, 300, 404] {
            // given
            let response = HTTPURLResponse(url: .mock, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            request.expectedResult.asURLRequest = .success(.mock)
            requestHandler.expectedResult.urlResponse = response

            // when
            let single = sut.execute(request: request)
            let singleResult = single.subscribeOn(scheduler).toBlocking().materialize()

            // then
            switch singleResult {
            case let .failed(_, error):
                XCTAssertEqual(true, error.asApiError?.isResponse)
            case .completed:
                XCTFail("Single should fail")
            }
        }
    }

    func testExecuteRequest_ValidStatusCode_ReturnData() {
        for statusCode in [200, 299] {
            // given
            let response = HTTPURLResponse(url: .mock, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            let testData = "Some test string".data(using: .utf8)
            request.expectedResult.asURLRequest = .success(.mock)
            requestHandler.expectedResult = .init(data: testData, urlResponse: response, error: nil)

            // when
            let single = sut.execute(request: request)
            let singleResult = single.subscribeOn(scheduler).toBlocking().materialize()

            // then
            switch singleResult {
            case .failed:
                XCTFail("Single should complete successfully")
            case let .completed(elements):
                XCTAssertEqual(testData, elements.first)
            }
        }
    }

}
