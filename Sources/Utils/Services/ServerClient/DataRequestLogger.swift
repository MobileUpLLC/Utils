//
//  DataRequestLogger.swift
//  Sever-minerals
//
//  Created by Petrovich on 08.11.2021.
//

import Foundation
import Alamofire

class DataRequestLogger {
    
    func logRequest(_ request: Request) {
        guard let urlRequest = request.request else {
            return
        }
                
        logRequest(urlRequest)
        printLogs(request.cURLDescription())
    }
    
    func printLogs(_ logs: String) {
        print(logs)
    }
    
    private func logRequest(_ urlRequest: URLRequest) {
        let url = urlRequest.url?.absoluteString ?? "Undefind"
        let method = urlRequest.httpMethod ?? "Undefind"
        let headers = composeHeaders(urlRequest.allHTTPHeaderFields)
        let body = composeData(urlRequest.httpBody)
        let time = Date()
        
        let msg = """
        
        -->
        URL: \(url)
        Method: \(method)
        Time: \(time)
        Headers: \(headers)
        Body: \(body)
        -->
        
        """
        
        printLogs(msg)
    }
    
    private func logResponse(with request: DataRequest) {
        logResponse(
            request.response,
            httpMethod: request.request?.method?.rawValue,
            data: request.data,
            error: request.error,
            elapsedTime: nil
        )
    }
    
    private func logResponse(
        _ response: HTTPURLResponse?,
        httpMethod: String?,
        data: Data?,
        error: Error?,
        elapsedTime: TimeInterval?
    ) {
        let url = response?.url?.absoluteString ?? "Undefind"
        let method = httpMethod ?? "Undefind"
        let statusCode = response?.statusCode ?? 0
        let headers = composeHeaders(response?.allHeaderFields)
        let error = error?.localizedDescription ?? "Empty"
        let body = composeData(data)
        
        let time: String
        if let elapsedTime = elapsedTime {
            time = String(format: "%.04f", elapsedTime)
        } else {
            time = "Undefind"
        }
        
        let msg = """
        
        <--
        URL: \(url)
        Method: \(method)
        StatusCode: \(statusCode)
        ElapsedTime: \(time)
        Headers: \(headers)
        Error: \(error)
        Data: \(body)
        <--
            
        """
        
        printLogs(msg)
    }
    
    private func composeData(_ data: Data?) -> String {
        guard let data = data else {
            return "Empty"
        }
        
        if let json = prettyString(from: data) {
            return "JSON \(json)"
        } else if let str = String(data: data, encoding: .utf8) {
            return "String \(str)"
        } else {
            return "Undefind"
        }
    }
    
    private func composeHeaders(_ headers: [AnyHashable: Any]?) -> String {
        guard let headers = headers, headers.isEmpty == false else {
            return "Empty"
        }
        
        var result = "[\n"
        for (key, value) in headers {
            result.append("    \(key): \(value)\n")
        }
        result.append("]")
        
        return result
    }
    
    private func prettyString(from jsonData: Data) -> String? {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let prettyString = String(data: prettyData, encoding: .utf8)
        else {
            return nil
        }
        
        return prettyString
    }
}

extension DataRequestLogger: EventMonitor {
    
    func requestDidResume(_ request: Request) {
        logRequest(request)
    }
    
    func requestDidFinish(_ request: Request) {
        guard let dataRequest = request as? DataRequest else {
            printLogs("Error: failed to convert request `\(request)` to DataRequest")
            return
        }
        
        logResponse(with: dataRequest)
    }
}
