//
//  BundleFileReader.swift
//  UtilsExample
//
//  Created by vitalii on 16.08.2022.
//

import Foundation
import Utils

struct Person: Codable, Equatable {
    
    let name: String
    let age: Int
}

class BundleFileReaderExample {
    
    func testDataEncoding() {
        let testObject = 434.33
        
        
        let encodedData = try JSONConverter.encode(object: testObject)
        
        let decodedData = try JSONConverter.decode(Double.self, data: encodedData)
        
        print(decodedData, testObject)
    }
    
    func testDictionaryEncoding() {
        let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]
        
        let encodedData = try JSONConverter.encode(dictionary: dictionary)
        
        let decodedData = try JSONConverter.decode(data: encodedData) as [String: Any]
        
        print(NSDictionary(dictionary: dictionary, copyItems: false), NSDictionary(dictionary: decodedData, copyItems: false))
    }
    
    func testJsonArrayEncoding() {
        let testBundle = Bundle(for: type(of: self))
        
        let initialDecodedData: [Person] = try BundleFileReader.readObject(name: "array", bundle: testBundle)
        
        let encodedData = try JSONConverter.encode(object: initialDecodedData)
        
        let finalDecodedData = try JSONConverter.decode([Person].self, data: encodedData)
        
        print(initialDecodedData, finalDecodedData)
    }
}
