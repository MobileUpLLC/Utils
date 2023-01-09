//
//  ExampleAsyncServerClient.swift
//  Skinepic
//
//  Created by Denis Sushkov on 11.10.2022.
//

import Alamofire
import Foundation
import Utils

class ExampleAsyncServerClient: AsyncHttpClient<ServerError> {
    static let shared = ExampleAsyncServerClient(baseUrl: "https://dog.ceo/")
    
    override func validateResponse(
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
    
    override func convertError(_ error: AFError) -> ServerError? {
        if error.responseCode == 404 {
            return .pageNotFound
        } else {
            return .unknown
        }
    }
    
    convenience init(baseUrl: String) {
        self.init(
            baseUrl: baseUrl,
            session: Session(eventMonitors: [DataRequestLogger()])
        )
    }
}
