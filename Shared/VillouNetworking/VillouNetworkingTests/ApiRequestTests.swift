//
//  ApiRequestTests.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import XCTest
@testable import VillouNetworking

class ApiRequestTests: XCTestCase {

    private var sutA: ApiRequestMock!
    private var sutB: ApiRequestMock!

    override func setUp() {
        super.setUp()

        sutA = ApiRequestMock()
        sutB = ApiRequestMock()
    }

}

// MARK: - Tests
extension ApiRequestTests {

    // MARK: asURLRequest

    func testAsURLRequest_URLSchemeIsSetCorrectly() throws {
        // given
        sutA.scheme = .http
        sutB.scheme = .https

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual("http", urlRequestA.url?.scheme)
        XCTAssertEqual("https", urlRequestB.url?.scheme)
    }

    func testAsURLRequest_URLHostIsSetCorrectly() throws {
        // given
        sutA.host = "www.google.com"
        sutB.host = "villou.com"

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual("www.google.com", urlRequestA.url?.host)
        XCTAssertEqual("villou.com", urlRequestB.url?.host)
    }

    func testAsURLRequest_URLPathIsSetCorrectly() throws {
        // given
        sutA.basePath = nil
        sutA.path = "/"
        sutB.basePath = "/api/2.0"
        sutB.path = "/users/login"

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual("/", urlRequestA.url?.path)
        XCTAssertEqual("/api/2.0/users/login", urlRequestB.url?.path)
    }

    func testAsURLRequest_InvalidURL_ShouldThrowInvalidRequestError() throws {
        // given
        sutA.basePath = nil
        sutA.path = "="

        do {
            // when
            _ = try sutA.asURLRequest()
            XCTFail("Should throw ApiError")
        } catch {
            // then
            guard let apiError = error.asApiError else { return XCTFail() }
            switch apiError {
            case .invalidRequest:
                break // success
            default:
                XCTFail()
            }
        }
    }

    func testAsURLRequest_HTTPMethodIsSetCorrectly() throws {
        // given
        sutA.method = .get
        sutB.method = .put

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual("GET", urlRequestA.httpMethod)
        XCTAssertEqual("PUT", urlRequestB.httpMethod)
    }

    func testAsURLRequest_HTTPHeadersAreSetCorrectly() throws {
        // given
        sutA.headers = ["header1234": "value1234",
                        "header8765": "value8765",
                        "header!!!": "value!!!"]

        // when
        let urlRequest = try sutA.asURLRequest()

        // then
        XCTAssertEqual("value1234", urlRequest.allHTTPHeaderFields?["header1234"])
        XCTAssertEqual("value8765", urlRequest.allHTTPHeaderFields?["header8765"])
        XCTAssertEqual("value!!!", urlRequest.allHTTPHeaderFields?["header!!!"])
    }

    func testAsURLRequest_HTTPContentTypeIsSetCorrectly() throws {
        // given
        sutA.contentType = .json
        sutB.contentType = nil

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual("application/json", urlRequestA.allHTTPHeaderFields?["Content-Type"])
        XCTAssertNil(urlRequestB.allHTTPHeaderFields?["Content-Type"])
    }

    func testAsURLRequest_HTTPBodyIsSetCorrectly() throws {
        // given
        let dict = ["keyA": "1234", "keyB": "9876", "keyC": "!!!"]
        let mockData = try JSONSerialization.data(withJSONObject: dict)
        sutA.body = mockData
        sutB.body = nil

        // when
        let urlRequestA = try sutA.asURLRequest()
        let urlRequestB = try sutB.asURLRequest()

        // then
        XCTAssertEqual(mockData, urlRequestA.httpBody)
        XCTAssertNil(urlRequestB.httpBody)
    }

}
