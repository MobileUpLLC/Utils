//
//  BundleFileReader.swift
//  
//
//  Created by vitalii on 16.08.2022.
//

import Foundation
// swiftlint:disable convenience_type
open class BundleFileReader {
    
    private enum Constants {
        
        static let jsonExtension: String = "json"
    }

    enum BundleFileReaderError: Error {
        
        case missingFile(String)
    }
    
    public static func readObject<T: Decodable>(name: String, bundle: Bundle = .main) throws -> T {
        let data = try readData(name: name, withExtension: Constants.jsonExtension, bundle: bundle)
        
        return try JSONConverter.decode(T.self, data: data)
    }
    
    public static func readJSON<T: Codable>(name: String, into type: T.Type, bundle: Bundle = .main) throws -> Any {
        let data = try readData(name: name, withExtension: Constants.jsonExtension, bundle: bundle)
        
        return try JSONConverter.decode(type, data: data)
    }
    
    public static func readData(name: String, withExtension ext: String, bundle: Bundle = .main) throws -> Data {
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            throw BundleFileReaderError.missingFile(
                "Bundle data with name: \(name) and extension: \(ext) couldn't be read"
            )
        }
        
        return try Data(contentsOf: url)
    }
}
