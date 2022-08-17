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

    func dataEncodingExample() {
        let testObject = 434.33

        do {
            let encodedData = try JSONConverter.encode(object: testObject)
            
            let decodedData = try JSONConverter.decode(Double.self, data: encodedData)

            print("dataEncodingExample success", decodedData, testObject)
        } catch {
            print("dataEncodingExample faild")
        }
    }

    func dictionaryEncodingExample() {
        let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]

        do {
            let encodedData = try JSONConverter.encode(dictionary: dictionary)
            
            let decodedData = try JSONConverter.decode(data: encodedData) as [String: Any]
            
            print(
                "dictionaryEncodingExample success",
                NSDictionary(dictionary: dictionary, copyItems: false),
                NSDictionary(dictionary: decodedData, copyItems: false)
            )
        } catch {
            print("dictionaryEncodingExample faild")
        }
    }

    func jsonArrayEncodingExample() {
        let testBundle = Bundle(for: type(of: self))
        
        do {
            let initialDecodedData: [Person] = try BundleFileReader.readObject(name: "array", bundle: testBundle)
            
            let encodedData = try JSONConverter.encode(object: initialDecodedData)
            
            let finalDecodedData = try JSONConverter.decode([Person].self, data: encodedData)
            
            print("jsonArrayEncodingExample success",initialDecodedData, finalDecodedData)
        } catch {
            print("jsonArrayEncodingExample faild")
        }
    }
}
