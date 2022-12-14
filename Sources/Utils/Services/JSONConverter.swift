//
//  JSONConverter.swift
//  
//
//  Created by vitalii on 16.08.2022.
//

import Foundation

public class JSONConverter {
    enum Error: Swift.Error {
        case parsing
    }
    
    public class func encode<T: Encodable>(
        object: T,
        dataEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate
    ) throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dataEncodingStrategy
        
        return try encoder.encode(object)
    }
    
    public class func encode(
        json: Any,
        options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        return try JSONSerialization.data(withJSONObject: json, options: options)
    }
    
    public class func encode(
        dictionary: [String : Any],
        options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        return try encode(json: dictionary, options: options)
    }
    
    public class func encode(
        jsonString: String,
        options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        return try encode(object: jsonString)
    }
    
    public class func decode<T: Decodable>(
        _ type: T.Type,
        data: Data,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        return try decoder.decode(type, from: data)
    }
    
    public class func decode<T: Decodable>(
        _ type: T.Type,
        json: Any,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) throws -> T {
        let data = try encode(json: json)
        
        return try decode(type, data: data, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    public class func decode<T: Decodable>(
        _ type: T.Type,
        dictionary: [String: Any],
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) throws -> T {
        let data = try encode(dictionary: dictionary)
        
        return try decode(type, data: data, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    public class func decode(
        data: Data,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any] {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
        guard let result = jsonObject as? [String: Any] else {
            throw Error.parsing
        }
        
        return result
    }
    
    public class func decode(
        data: Data,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> String {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
        let prettyData = try encode(json: jsonObject, options: .prettyPrinted)
        let prettyString = String(data: prettyData, encoding: .utf8)

        return prettyString ?? ""
    }
}
