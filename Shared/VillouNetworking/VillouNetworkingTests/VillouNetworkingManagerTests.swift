//
//  VillouNetworkingManagerTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import XCTest
@testable import VillouNetworking

class VillouNetworkingManagerTests: XCTestCase {

    private var sut: VillouNetworkingManager!
    private var requestHandlerMock: URLRequestHandlerMock!

    override func setUp() {
        super.setUp()

        requestHandlerMock = URLRequestHandlerMock()
        sut = VillouNetworkingManager(urlRequestHandler: requestHandlerMock)
    }

}

// MARK: Tests
extension VillouNetworkingManagerTests {

    func testExecuteRequest_InvalidURLRequest_ReturnError
}
//
//public func execute(request: ApiRequest) -> Single<Data?> {
//    do {
//        let urlRequest = try request.asURLRequest()
//        return handle(urlRequest: urlRequest)
//    } catch {
//        return .error(error)
//    }
//}
//
//private func handle(urlRequest: URLRequest) -> Single<Data?> {
//    return urlRequestHandler.handle(request: urlRequest)
//        .map { data, urlResponse, error -> Data? in
//            guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
//                throw ApiError.invalidResponse(error)
//            }
//
//            guard 200..<300 ~= statusCode else {
//                throw ApiError.response(error, statusCode: statusCode, data: data)
//            }
//
//            return data
//        }
//}
