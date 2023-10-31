//
//  AuthTests.swift
//  EmbarqueTenaresSwiftUITests
//
//  Created by Elkin Garcia on 10/30/23.
//

import XCTest

final class HttpHeaderTests: XCTestCase {
    
    func testGetHttpHeaders() async throws {
        // Create a mock Firestore document with the required fields.
        let documentSnapshot = FirestoreMock().document("auth", documentID: "login")
        documentSnapshot.data = [
            "Api-Key": "1234567890",
            "App-Id": "my-app-id",
            "url": "https://example.com/api"
        ]

        // Create a mock HttpHeader object.
        let httpHeader = HttpHeader()

        // Call the getHttpHeaders() function.
        await httpHeader.getHttpHeaders()

        // Assert that the API key, app ID, and URL properties are correctly updated.
        XCTAssertEqual(httpHeader.apiKey, "1234567890")
        XCTAssertEqual(httpHeader.appId, "my-app-id")
        XCTAssertEqual(httpHeader.url, "https://example.com/api")

        // Assert that the httpHeaderChanged property is set to true.
        XCTAssertTrue(httpHeader.httpHeaderChanged)
    }

    func testFirebaseToken() async throws {
        // Create a mock Auth object with a user ID token.
        let authMock = AuthMock()
        authMock.currentUser?.idToken = "my-id-token"

        // Create a mock HttpHeader object.
        let httpHeader = HttpHeader()

        // Call the firebaseToken() function.
        let token = try await httpHeader.firebaseToken()

        // Assert that the user's ID token is correctly retrieved.
        XCTAssertEqual(token, "my-id-token")
    }
}
