//
//  HttpClient.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct HttpClient {
    // MARK: - Properties
    private let jsonConverter: HttpJsonConverter
    private let logger: HttpLogger?
    
    // MARK: - Init
    
    /// Default initializer.
    init() {
        self.logger = DefaultHttpLogger()
        self.jsonConverter = DefaultHttpJsonConverter()
    }
    
    /// Initialize with custom logger.
    /// - Parameter logger: The logger object to be used. Set as nil to disable logging.
    init(logger: HttpLogger?) {
        self.logger = logger
        self.jsonConverter = DefaultHttpJsonConverter()
    }
    
    /// Initialize with custom Json converter.
    /// - Parameter jsonConverter: The Json converter object used for encoding and decoding.
    init(jsonConverter: HttpJsonConverter) {
        self.logger = DefaultHttpLogger()
        self.jsonConverter = jsonConverter
    }
    
    /// Initialize with custom Json converter and logger.
    /// - Parameter jsonConverter: The Json converter object used for encoding and decoding.
    /// - Parameter logger: The logger object to be used. Set as nil to disable logging.
    init(jsonConverter: HttpJsonConverter, logger: HttpLogger?) {
        self.jsonConverter = jsonConverter
        self.logger = logger
    }
    
    //MARK: - Methods
    
    /// Perform an Http request.
    /// - Parameters:
    ///   - request: The request  to be performed.
    ///   - success: Success closure.
    ///   - failure: Failure closure.
    func perform<T: Decodable>(request: HttpRequest, responseType: T.Type, success: @escaping (HttpResponse<T>) -> (), failure: @escaping (Error?) -> ()) {
        do {
            guard let urlRequest:URLRequest = try buildURLRequest(with: request)
            else {
                failure(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (responseData, urlResponse, responseError) in
                if let error = responseError {
                    failure(error)
                }
                else if let response = urlResponse as? HTTPURLResponse {
                    var httpResponse = HttpResponse<T>(response: response)
                    
                    if let data = responseData {
                        do {
                            httpResponse.body = try self.jsonConverter.getObject(from: data)
                            success(httpResponse)
                        }
                        catch {
                            failure(error)
                        }
                    }
                    else {
                        httpResponse.body = nil
                        success(httpResponse)
                    }
                }
                else {
                    failure(nil)
                }
            }
            
            task.resume()
        }
        catch {
            failure(error)
        }
    }
    
    //MARK: - Helper Methods
    
    /// Build URLRequest from information provided by HttpRequest instance.
    /// - Parameter request: HttpRequest instance describing the request.
    /// - Throws: Error if couldn't build URLRequest for any reason.
    /// - Returns: URLRequest ready to be used.
    private func buildURLRequest(with request: HttpRequest) throws -> URLRequest? {
        guard let encodedUrlString = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.logger?.logError(description: "Couldn't encode request url")
            return nil
        }
        
        guard let requestUrl:URL = URL(string: encodedUrlString) else {
            self.logger?.logError(description: "Couldn't initialize a valid URL for request")
            return nil
        }
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = request.method.rawValue
        
        if let headers = request.headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let parameters = request.bodyParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch {
                self.logger?.logError(error, description: "Couldn't set httpBody for request")
                throw error
            }
        }
        
        return urlRequest
    }
}
