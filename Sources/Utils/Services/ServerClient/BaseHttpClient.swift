//
//  BaseHttpClient.swift
//  Sever-minerals
//
//  Created by Petrovich on 08.11.2021.
//

import Alamofire

open class BaseHttpClient {
    
    let baseUrl: String
    let session: Session
    
    var defaultHeaders: HTTPHeaders? { nil }
    
    public convenience init(baseUrl: String) {
        self.init(
            baseUrl: baseUrl,
            session: Session(eventMonitors: [DataRequestLogger()])
        )
    }
    
    public init(baseUrl: String, session: Session) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    open func request<Parameters: Encodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> DataRequest {
        let url = getFullUrl(from: endpoint)
        let requestHeaders = getHeaders(from: headers)
        
        return session.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: requestHeaders,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
    }
    
    open func request(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> DataRequest {
        let url = getFullUrl(from: endpoint)
        let requestHeaders = getHeaders(from: headers)
        
        return session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: requestHeaders,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
    }
    
    open func upload(
        endpoint: String,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> UploadRequest {
        let url = getFullUrl(from: endpoint)
        let requestHeaders = getHeaders(from: headers)
        
        return session.upload(
            multipartFormData: multipartFormData,
            to: url,
            method: .post,
            headers: requestHeaders,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
    }
    
    open func download(
        fileURL: String,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> DownloadRequest {
        let destination = Alamofire.DownloadRequest.suggestedDownloadDestination(
            for: .documentDirectory,
            in: .userDomainMask,
            options: [.createIntermediateDirectories, .removePreviousFile]
        )
        
        return session.download(
            fileURL,
            method: .get,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier,
            to: destination
        )
    }
    
    private func getFullUrl(from endpoint: String) -> URLConvertible {
        return baseUrl + endpoint
    }
    
    private func getHeaders(from headers: HTTPHeaders?) -> HTTPHeaders? {
        return headers ?? defaultHeaders
    }
}
