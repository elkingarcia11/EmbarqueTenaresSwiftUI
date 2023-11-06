import XCTest
import SwiftUI
import UserNotifications

class NotifUnitTests: XCTestCase {
    
    func testIsValidString(){
        XCTAssertNoThrow(try Notif(title: "Valid string", body: "Valid string", dateComponent: DateComponents()))
    }
    
    func testIsEmptyString(){
        XCTAssertNoThrow(try Notif(title: "", body: "", dateComponent: DateComponents()))
    }
    
    func testIsWhiteSpaceString(){
        XCTAssertNoThrow(try Notif(title: "  ", body: " ", dateComponent: DateComponents()))
    }
    
    func testInvalidDateComponents(){
        XCTAssertThrowsError(try Notif( title: "", body: "", dateComponent: DateComponents(year: 201324, month: 1312, day: 31210, hour: 13132, minute: 0312312)))
    }
    
    func testValidDateComponents(){
        XCTAssertNoThrow(try Notif(title: "", body: "", dateComponent: DateComponents(year: 1995, month: 1, day: 10, hour: 12, minute: 0)))
    }
    
}
