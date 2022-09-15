//
//  ExampleServerClient.swift
//  UtilsExample
//
//  Created by Чаусов Николай on 18.08.2022.
//

import Foundation
import Utils
import Alamofire

enum ServerError: Error {
    
    case pageNotFound
    case unacceptableStatusCode(Int)
    case unknown
}

class ExampleServerClient: HttpClient<ServerError> {
    
    static let shared = ExampleServerClient(baseUrl: "https://dog.ceo/")
    
    convenience init(baseUrl: String) {
        self.init(
            baseUrl: baseUrl,
            session: Session(eventMonitors: [DataRequestLogger()]))
    }
    
    override class func convertError(_ error: AFError) -> ServerError {
        DeveloperToolsLogger.logMessage("Converting error", level: .error, message: "\(error)")
        
        if error.responseCode == 404 {
            return .pageNotFound
        } else {
            return .unknown
        }
    }
    
    override class func validateResponse(
        request: URLRequest?,
        response: HTTPURLResponse,
        data: Data?
    ) -> Result<Void, ServerError> {
        if (200..<300).contains(response.statusCode) {
            return .success(Void())
        } else {
            return .failure(ServerError.unacceptableStatusCode(response.statusCode))
        }
    }
    
    @discardableResult
    override func post<T: Decodable>(
        type: T.Type,
        endpoint: String,
        parameters: [String: Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, ServerError>) -> Void
    ) -> DataRequest {
        return
            performRequest(
                method: .post,
                type: type,
                endpoint: endpoint,
                parameters: parameters,
                decoder: decoder,
                completion: completion
            )
    }
    
    @discardableResult
    override func get<T: Decodable>(
        type: T.Type,
        endpoint: String,
        parameters: [String: Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, ServerError>) -> Void
    ) -> DataRequest {
        return
            performRequest(
                method: .get,
                type: type,
                endpoint: endpoint,
                parameters: parameters,
                decoder: decoder,
                completion: completion
            )
    }
    
    private func performRequest<T: Decodable>(
        method: HTTPMethod,
        type: T.Type,
        endpoint: String,
        parameters: [String : Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, ServerError>) -> Void
    ) -> DataRequest {
        let encoding: ParameterEncoding = method == .post ? JSONEncoding.default : URLEncoding.default
        
        let dataRequest = request(
            endpoint: endpoint,
            method: method,
            parameters: parameters,
            encoding: encoding
        )
        
        return dataRequest
            .validate(Self.validate(request:response:data:))
            .responseDecodable(of: type, decoder: decoder) { response in
                Self.handleResponse(response, completion: completion)
            }
    }
}
