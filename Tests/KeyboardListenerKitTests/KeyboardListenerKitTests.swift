import XCTest
@testable import KeyboardListenerKit

final class KeyboardListenerKitTests: XCTestCase {
    func testGlobalKeyListener() {
        let listener = KeyboardListener()
        XCTAssertNotNil(listener)
        
        listener.startListening()
        listener.stopListening()

        XCTAssert(true)
    }
}
