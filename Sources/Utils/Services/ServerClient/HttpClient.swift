//
//  HttpClient.swift
//
//  Created by Petrovich on 08.11.2021.
//

import Foundation
import Alamofire

open class HttpClient<E: Error>: BaseHttpClient {
    open func post<T: Decodable>(
        type: T.Type,
        endpoint: String,
        parameters: [String: Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, E>) -> Void
    ) -> DataRequest {
        return request(endpoint: endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(Self.validate(request:response:data:))
            .responseDecodable(of: type, decoder: decoder) { response in
                Self.handleResponse(response, completion: completion)
            }
    }
    
    open func get<T: Decodable>(
        type: T.Type,
        endpoint: String,
        parameters: [String: Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, E>) -> Void
    ) -> DataRequest {
        return request(endpoint: endpoint, method: .get, parameters: parameters)
            .validate(Self.validate(request:response:data:))
            .responseDecodable(of: type, decoder: decoder) { response in
                Self.handleResponse(response, completion: completion)
            }
    }
    
    @discardableResult
    open func upload<T: Decodable>(
        type: T.Type,
        endpoint: String,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        decoder: JSONDecoder = JSONDecoder(),
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, E>) -> Void
    ) -> UploadRequest {
        return upload(endpoint: endpoint, multipartFormData: multipartFormData, headers: headers)
            .validate(Self.validate(request:response:data:))
            .responseDecodable(of: type, decoder: decoder) { response in
                Self.handleResponse(response, completion: completion)
            }
    }
    
    @discardableResult
    open func download(
        fileURL: String,
        decoder: JSONDecoder = JSONDecoder(),
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<URL?, E>) -> Void
    ) -> DownloadRequest {
        return download(fileURL: fileURL, headers: headers)
            .response(completionHandler: { response in
                Self.handleDownloadResponse(response, completion: completion)
            })
    }
    
    open class func validateResponse(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Result<Void, E> {
        fatalError("Subclasses must implemet this method")
    }
    
    open class func convertError(_ error: AFError) -> E {
        fatalError("Subclasses must implemet this method")
    }
    
    open class func handleResponse<T>(
        _ response: DataResponse<T, AFError>,
        completion: @escaping (Result<T, E>) -> Void
    ) {
        switch response.result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(Self.convertError(error)))
        }
    }
    
    open class func handleDownloadResponse(
        _ response: DownloadResponse<URL?, AFError>,
        completion: @escaping (Result<URL?, E>) -> Void
    ) {
        switch response.result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(Self.convertError(error)))
        }
    }
        
    open class func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Result<Void, Error> {
        return validateResponse(request: request, response: response, data: data)
            .mapError { $0 as Error }
    }
}
