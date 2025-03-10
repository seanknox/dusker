import XCTest
@testable import DuskerKit

final class DuskerKitTests: XCTestCase {
    func testSurfSessionInitialization() {
        let session = SurfSession()
        XCTAssertNotNil(session.id)
        XCTAssertNil(session.endDate)
        XCTAssertEqual(session.totalWaves, 0)
    }
    
    func testWaveInitialization() {
        let wave = Wave()
        XCTAssertNotNil(wave.id)
        XCTAssertEqual(wave.confidence, 1.0)
    }
    
    func testDateUtilities() {
        let date = Date()
        XCTAssertFalse(date.formattedDate().isEmpty)
        XCTAssertFalse(date.formattedTime().isEmpty)
        XCTAssertFalse(date.formattedDay().isEmpty)
    }
} 