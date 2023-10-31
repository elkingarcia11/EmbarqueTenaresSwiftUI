import Foundation
class UNUserNotificationCenterMock {

    var requestAuthorizationCalled = false
    var addedRequest: UNNotificationRequest?

    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        requestAuthorizationCalled = true
        completionHandler(true, nil)
    }

    func add(_ request: UNNotificationRequest, completionHandler: @escaping (Error?) -> Void) {
        addedRequest = request
        completionHandler(nil)
    }
}
