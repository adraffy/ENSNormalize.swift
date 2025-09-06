//
//  ENSNormalizeTests.swift
//  ENSNormalizeTests
//
//  Created by raffy.eth on 8/23/25.
//

import Foundation
import XCTest

@testable import ENSNormalize

func readJSON(_ name: String) throws -> Data {
    guard let url = Bundle.module.url(forResource: name, withExtension: "json")
    else {
        fatalError("Missing: \(name).json")
    }
    return try Data(contentsOf: url)
}

public class ENSNormalizeTests: XCTestCase {

    func testNF() throws {
        var errors = 0
        for (_, tests) in try JSONDecoder().decode(
            [String: [[String]]].self,
            from: try readJSON("nf-tests")
        ) {
            for test in tests {
                let input = explode(test[0])
                let nfd0 = explode(test[1])
                let nfc0 = explode(test[2])
                let nfd = ENSIP15.shared.nf.D(input)
                let nfc = ENSIP15.shared.nf.C(input)
                if nfd != nfd0 {
                    errors += 1
                    print(
                        "Wrong NFD: Expect[\(toHexSequence(nfd0))] Got[\(toHexSequence(nfd))]"
                    )
                }
                if nfc != nfc0 {
                    errors += 1
                    print(
                        "Wrong NFC: Expect[\(toHexSequence(nfc0))] Got[\(toHexSequence(nfc))]"
                    )
                }
            }
        }
        XCTAssertEqual(errors, 0)
    }

    func testValidation() throws {
        struct Test: Decodable {
            var name: String
            var norm: String?
            var error: Bool?
        }
        var errors = 0
        for test in try JSONDecoder().decode(
            [Test].self,
            from: try readJSON("tests")
        ) {
            let name = explode(test.name)
            let norm0 = explode(test.norm ?? test.name)
            let shouldError = test.error ?? false
            do {
                let norm = try ENSIP15.shared.normalize(name)
                if shouldError {
                    errors += 1
                    print(
                        "Expected Error: [\(toHexSequence(name))] Got[\(toHexSequence(norm))]"
                    )
                } else if norm != norm0 {
                    errors += 1
                    print(
                        "Wrong Norm: [\(toHexSequence(name))] Expect[\(toHexSequence(norm0))] Got[\(toHexSequence(norm))]"
                    )
                }
            } catch {
                if !shouldError {
                    errors += 1
                    print(
                        "Unexpected Error: [\(toHexSequence(name))] Expect[\(toHexSequence(norm0))] \(error)"
                    )
                }
            }
        }
        XCTAssertEqual(errors, 0)
    }

    func testReadme() throws {
        XCTAssertEqual(
            try "RaFFY🚴‍♂️.eTh".ensNormalized(),
            "raffy\u{1F6B4}\u{200D}\u{2642}.eth"
        )
        XCTAssertEqual(
            try "1⃣2⃣.eth".ensBeautified(),
            "1\u{FE0F}\u{20E3}2\u{FE0F}\u{20E3}.eth"
        )
    }

    func testProperties() throws {
        XCTAssert(ENSIP15.shared.shouldEscape.contains(0x202E))
        XCTAssert(ENSIP15.shared.combiningMarks.contains(0x20E3))
    }

    func testSafeCodepoint() throws {
        XCTAssertEqual(ENSIP15.shared.safeCodepoint(0x61), "\"a\" {61}")
        XCTAssertEqual(
            ENSIP15.shared.safeCodepoint(0x303),
            "\"\u{25CC}\u{303}\u{200E}\" {303}"
        )
        XCTAssertEqual(ENSIP15.shared.safeCodepoint(0xFE0F), "{FE0F}")
    }

    func testFragments() throws {
        func f(_ name: String) throws -> String {
            XCTAssertThrowsError(try name.ensNormalized())
            return try ENSIP15.normalizeFragment(name)
        }
        XCTAssertEqual(try f("AB--"), "ab--")
        XCTAssertEqual(try f("z\u{303}"), "z̃")
        XCTAssertEqual(try f("\u{3BF}\u{43E}"), "οо")
    }

}
