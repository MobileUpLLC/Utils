//
//  AsyncHttpClient.swift
//  Skinepic
//
//  Created by Denis Sushkov on 10.10.2022.
//

import Foundation
import Alamofire

open class AsyncHttpClient<E: Error>: BaseHttpClient {
    open func performRequest<T: Decodable, P: Encodable>(
        method: HTTPMethod,
        type: T.Type,
        endpoint: String,
        parameters: P,
        headers: HTTPHeaders? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let encoder = getParameterEncoder(method: method)
        
        do {
            return try await request(
                endpoint: endpoint,
                method: method,
                parameters: parameters,
                encoder: encoder,
                headers: headers
            )
                .validate(validate(request:response:data:))
                .serializingDecodable(type, decoder: decoder)
                .value
        } catch let error as AFError {
            throw convertError(error) ?? AFError.explicitlyCancelled
        }
    }
    
    open func performRequest<T: Decodable>(
        method: HTTPMethod,
        type: T.Type,
        endpoint: String,
        headers: HTTPHeaders? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let encoder = getParameterEncoder(method: method)
        
        do {
            return try await request(
                endpoint: endpoint,
                method: method,
                parameters: nil as String?,
                encoder: encoder,
                headers: headers
            )
            .validate(validate(request:response:data:))
            .serializingDecodable(type, decoder: decoder)
            .value
        } catch let error as AFError {
            throw convertError(error) ?? AFError.explicitlyCancelled
        }
    }
    
    open func performRequest(method: HTTPMethod, endpoint: String) async throws -> Data {
        let encoder = getParameterEncoder(method: method)

        do {
            return try await request(
                endpoint: endpoint,
                method: method,
                parameters: nil as String?,
                encoder: encoder
            )
            .validate(validate(request:response:data:))
            .serializingData()
            .value
        } catch let error as AFError {
            throw convertError(error) ?? AFError.explicitlyCancelled
        }
    }
    
    open func validateResponse(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Result<Void, E> {
        assertionFailure("Subclasses must implement this method")
        
        return .success(Void())
    }
    
    open func convertError(_ error: AFError) -> E? {
        assertionFailure("Subclasses must implement this method")
        
        return nil
    }
    
    open func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Result<Void, Error> {
        return validateResponse(request: request, response: response, data: data)
            .mapError { $0 as Error }
    }
    
    private func getParameterEncoder(method: HTTPMethod) -> ParameterEncoder {
        return method == .post || method == .put
            ? JSONParameterEncoder.default
            : URLEncodedFormParameterEncoder.default
    }
}
