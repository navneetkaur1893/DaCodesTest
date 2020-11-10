//
//  RequestManager.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

/**
 Basic wrapper of URLSession
 */
public class RequestManager {
    /// Underlying session
    public var session: URLSession
    let contentType = Constants.ContentType
    let accept = Constants.Accept
    /**
     HTTP method definitions
     */
    public enum Method: String {
        /// GET
        case get
        /// POST
        case post
    }
    
    /**
     Network error types
     */
    public enum ErrorTypes: Error {
        /// Unknown network error
        case unknownError
        /// Parameters are invalid, URL Request couldn't be created
        case urlRequestCouldNotBeCreated
        /// Service returned an error
        case serverError(Error)
    }
    /**
     A shared instance of 'RequestManager'
     */
    public static let sharedInstance: RequestManager = {
        return RequestManager(session: URLSession.shared)
    }()
    
    /**
     Initialize the 'RequestManager' instance with specified configuration
     - parameter session: The session that is used to construct managed session.
     'URLSession.shared' by default
     - returns:                 The new 'RequestManager' instance'
     */
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - createRequest
    /**
     Creates a request for the specified URL, method, headers, parameters .
     
     - parameter url:  The URL string.
     - parameter method:     The HTTP method.
     - parameter parameters: The parameters. `nil` by default.
     - parameter headers:    The HTTP headers. `nil` by default.
     
     - returns: The created request.
     */
    public func createRequest(
        url: String,
        method: Method,
        cachePolicy: URLRequest.CachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy,
        parameters: [String: Any]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil) -> URLRequest? {
        guard var baseURL = URL(string: url) else {return nil}
        var queryItems = [URLQueryItem]()
        if method == .get, let parameters = parameters as? [String: String] {
            parameters.forEach {
                let queryItem = URLQueryItem(name: $0, value: $1)
                queryItems.append(queryItem)
            }
            guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
            components.queryItems = queryItems
            guard let url = components.url else { return nil }
            baseURL = url
        }
        // Make the request for the given method.
        var urlRequest = URLRequest(url: baseURL, cachePolicy: cachePolicy)
        urlRequest.httpMethod = method.rawValue.uppercased()
        
        // Add any body JSON params (for POSTs).
        if let requestBody = body, method != .get {
            urlRequest.httpBody = requestBody
        } else if let params = parameters, method != .get {
            let data = try? JSONSerialization.data(withJSONObject: params, options: [])
            if urlRequest.value(forHTTPHeaderField: contentType) == nil {
                urlRequest.setValue(Constants.ApplicationJSON, forHTTPHeaderField: contentType)
            }
            urlRequest.httpBody = data
        }
        // Add any extra headers if given.
        if let headers = headers {
            for (headerField, headerValue) in headers {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        if urlRequest.value(forHTTPHeaderField: accept) == nil {
            urlRequest.addValue(Constants.ApplicationJSON, forHTTPHeaderField: accept)
        }
        return urlRequest
    }
    
    // MARK: - processRequest
    /**
     Processes request for the specified method, URL string, parameters and headers.
     - parameter method:         HTTP method
     - parameter url:            URL String
     - parameter parameters:     Parameters. 'nil' by default.
     - parameter headers:        HTTP headers. 'nil' by default.
     
     - returns: The result type.
     */
    func processRequest(
        url: String,
        method: Method,
        headers: [String: String]? = nil,
        parameters: [String: Any]? = nil,
        body: Data? = nil,
        cachePolicy: URLRequest.CachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy,
        completion: @escaping (Result<Data, Error>) -> Void) {
        let queue = DispatchQueue.main
        guard let createdRequest = createRequest(url: url,
                                                 method: method,
                                                 cachePolicy: cachePolicy,
                                                 parameters: parameters,
                                                 body: body,
                                                 headers: headers)else {
            queue.async {
                completion(.failure(ErrorTypes.urlRequestCouldNotBeCreated))
            }
            return
        }
        let dataTask = session.dataTask(with: createdRequest,
                                        completionHandler: {( taskData, taskResponse, taskError) -> Void in
                                            guard let data = taskData else {
                                                if let error = taskError {
                                                    queue.async { completion(.failure(error))
                                                    }
                                                } else {
                                                    queue.async { completion(.failure(ErrorTypes.unknownError))
                                                    }
                                                }
                                                return
                                            }
                                            queue.async { completion(.success(data))
                                            }
                                        })
        dataTask.resume()
    }
    
    // MARK: - Methods Functions
    /**
     Sends POST request
     - parameter url:            URL String
     - parameter headers:        HTTP headers. 'nil' by default.
     - parameter parameters:     Parameters. 'nil' by default.
     - completion:                                       Completion handler with result type arguments: (Result<Data, Error>)
     */
    public func post(url: String,
                     headers: [String: String]? = nil,
                     parameters: [String: Any]? = nil,
                     body: Data? = nil,
                     cachePolicy: URLRequest.CachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy,
                     completion: @escaping (Result<Data, Error>) -> Void) {
        processRequest(url: url,
                       method: .post,
                       headers: headers,
                       parameters: parameters,
                       body: body,
                       cachePolicy: cachePolicy,
                       completion: completion)
    }
    
    /**
     Sends GET request
     - parameter url:            URL String
     - parameter headers:        HTTP headers. 'nil' by default.
     - parameter parameters:     Parameters. 'nil' by default.
     - parameter completion:     Completion handler with result type arguments: (Result<Data, Error>)
     */
    public func get(url: String,
                    headers: [String: String]? = nil,
                    parameters: [String: Any]? = nil,
                    cachePolicy: URLRequest.CachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy,
                    completion: @escaping (Result<Data, Error>) -> Void) {
        processRequest(url: url,
                       method: .get,
                       headers: headers,
                       parameters: parameters,
                       cachePolicy: cachePolicy,
                       completion: completion)
    }
}
