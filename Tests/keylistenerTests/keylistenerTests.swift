import XCTest
@testable import keylistener

final class keylistenerTests: XCTestCase {
    func testGlobalKeyListener() {
        let listener = GlobalKeyListener()
        XCTAssertNotNil(listener)
        
        listener.startListening()
        listener.stopListening()

        XCTAssert(true)
    }
}
