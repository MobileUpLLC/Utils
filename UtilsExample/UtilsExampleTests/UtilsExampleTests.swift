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
            XCTFail("Data encoding fall")
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
            XCTFail("Dictionary encoding fall")
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
            XCTFail("Array encoding fall")
        }
    }
    
    func testMulticastDelegateInvoke() {
        let multicastDelegate = MulticastDelegate<Delegate>()
        
        let a = A()
        let b = B()
        let c = C()
        
        multicastDelegate.add(delegate: a)
        multicastDelegate.add(delegate: b)
        multicastDelegate.add(delegate: c)
        
        multicastDelegate.invokeForEachDelegate { delegate in
            XCTAssertTrue(["A", "B", "C"].contains { delegate.foo() == $0 })
        }
    }
    
    func testMulticastDelegateNilObject() {
        let multicastDelegate = MulticastDelegate<Delegate>()
        
        let a = A()
        let b = B()
        var c: C? = C()
        
        multicastDelegate.add(delegate: a)
        multicastDelegate.add(delegate: b)
        multicastDelegate.add(delegate: c!)
        
        c = nil
        
        multicastDelegate.invokeForEachDelegate { delegate in
            DispatchQueue.main.async {
                XCTAssertTrue(["A", "B"].contains { delegate.foo() == $0 })
            }
        }
    }
}
