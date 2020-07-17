//
//  NetworkingManagerTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxBlocking
import RxSwift
import XCTest
@testable import VillouNetworking

class NetworkingManagerTests: XCTestCase {

    struct TestDataModel: Codable {
        let value: String
    }

    class Mock: NetworkingManager {
        var expectedExecuteRequestResult: Result<Data?, ApiError> = .failure(.unknown)

        func execute(request: ApiRequest) -> Single<Data?> {
            switch expectedExecuteRequestResult {
            case let .success(data):
                return .just(data)
            case let .failure(apiError):
                return .error(apiError)
            }
        }
    }

    // mock sut
    var sutMock: Mock!

    // other mocks
    var request: ApiRequestMock!

    // rx scheduler
    private var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        sutMock = Mock()
        request = ApiRequestMock()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        request = nil
        sutMock = nil
        scheduler = nil
        super.tearDown()
    }
}

// MARK: - execute(request:decodeType:) default implementation tests
extension NetworkingManagerTests {

    // MARK: Single<T>

    func testExecuteRequestDecodeType_DataIsNil_ReturnDecodingError() {
        // given
        sutMock.expectedExecuteRequestResult = .success(nil)

        // when
        let single: Single<TestDataModel> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case let .failed(_, error):
            XCTAssertEqual(true, error.asApiError?.isDecoding)
        case .completed:
            XCTFail("Single should fail")
        }
    }

    func testExecuteRequestDecodeType_JsonDecodingError_ReturnDecodingError() throws  {
        // given
        let emptyData = Data()
        sutMock.expectedExecuteRequestResult = .success(emptyData)

        // when
        let single: Single<TestDataModel> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case let .failed(_, error):
            if case let .decoding(underlying) = error.asApiError {
                XCTAssertNotNil(underlying as? DecodingError)
            } else {
                XCTFail("Incorrect Single result error")
            }
        case .completed:
            XCTFail("Single should fail")
        }
    }

    func testExecuteRequestDecodeType_ValidData_ReturnDecodedValue() throws  {
        // given
        let model = TestDataModel(value: "Testing value 123!")
        let testData = try JSONEncoder().encode(model)
        sutMock.expectedExecuteRequestResult = .success(testData)

        // when
        let single: Single<TestDataModel> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case .failed:
            XCTFail("Single should complete successfully")
        case let .completed(elements):
            XCTAssertEqual(model.value, elements.first?.value)
        }
    }

    // MARK: Single<T?>

    func testExecuteRequestDecodeTypeOptional_DataIsNil_ReturnDecodingError() {
        // given
        sutMock.expectedExecuteRequestResult = .success(nil)

        // when
        let single: Single<TestDataModel?> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case .failed:
            XCTFail("Single should complete successfully")
        case let .completed(elements):
            XCTAssertEqual(1, elements.count)
            XCTAssertNil(elements.first??.value)
        }
    }

    func testExecuteRequestDecodeTypeOptional_JsonDecodingError_ReturnDecodingError() throws  {
        // given
        let emptyData = Data()
        sutMock.expectedExecuteRequestResult = .success(emptyData)

        // when
        let single: Single<TestDataModel?> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case .failed:
            XCTFail("Single should complete successfully")
        case let .completed(elements):
            XCTAssertEqual(1, elements.count)
            XCTAssertNil(elements.first??.value)
        }
    }

    func testExecuteRequestDecodeTypeOptional_ValidData_ReturnDecodedValue() throws  {
        // given
        let model = TestDataModel(value: "Testing value 123!")
        let testData = try JSONEncoder().encode(model)
        sutMock.expectedExecuteRequestResult = .success(testData)

        // when
        let single: Single<TestDataModel?> = sutMock.execute(request: request, decodeType: TestDataModel.self)
        let singleResult = single.observeOn(scheduler).toBlocking().materialize()

        // then
        switch singleResult {
        case .failed:
            XCTFail("Single should complete successfully")
        case let .completed(elements):
            XCTAssertEqual(model.value, elements.first??.value)
        }
    }

}
