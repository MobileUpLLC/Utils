//
//  UtilsExampleTests.swift
//  UtilsExampleTests
//
//  Created by vitalii on 17.08.2022.
//

import XCTest
import Utils

struct Person: Codable, Equatable {
    
    let name: String
    let age: Int
}

class UtilsExampleTests: XCTestCase {
    
    private enum Constnts {
        
        static let jsonFileName: String = "jsonArrayForBundleFileReaderTest"
    }
    
    func testDataEncoding() {
        let testObject = 434.33
        
        do {
            let encodedData = try JSONConverter.encode(object: testObject)
            let decodedData = try JSONConverter.decode(Double.self, data: encodedData)
            
            XCTAssertEqual(decodedData, testObject)
        } catch {
            XCTFail()
        }
    }
    
    func testDictionaryEncoding() {
        let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]
        
        do {
            let encodedData = try JSONConverter.encode(dictionary: dictionary)
            let decodedData = try JSONConverter.decode(data: encodedData) as [String: Any]
            
            XCTAssertEqual(
                NSDictionary(dictionary: dictionary, copyItems: false),
                NSDictionary(dictionary: decodedData, copyItems: false)
            )
        } catch {
            XCTFail()
        }
    }
    
    func testJsonArrayEncoding() {
        do {
            let initialDecodedData: [Person] = try BundleFileReader.readObject(
                name: Constnts.jsonFileName,
                bundle: Bundle.main.self
            )
            let encodedData = try JSONConverter.encode(object: initialDecodedData)
            let finalDecodedData = try JSONConverter.decode([Person].self, data: encodedData)
            
            XCTAssertNotNil(initialDecodedData)
            XCTAssertEqual(initialDecodedData, finalDecodedData)
        } catch {
            XCTFail()
        }
    }
}
