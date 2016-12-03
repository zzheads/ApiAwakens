//
//  APIClient.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

public let ZZHNetworkingErrorDomain = "com.zzheads.ApiAwakens.NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletion = (JSON?, HTTPURLResponse?, Error?) -> Void
typealias JSONTask = URLSessionDataTask

typealias JSONArray = [JSON]

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol JSONDecodable {
    init?(JSON: JSON)
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWithRequest(request: URLRequest, completion: @escaping JSONTaskCompletion) -> JSONTask
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (APIResult<T>) -> Void)
}

extension APIClient {
    
    func JSONTaskWithRequest(request: URLRequest, completion: @escaping JSONTaskCompletion) -> JSONTask {
        let task = session.dataTask(with: request) { data, response, error in
            print("Request in JSONTask: \(request)")
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: ZZHNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completion(json, HTTPResponse, nil)
                    } catch let error {
                        completion(nil, HTTPResponse, error)
                    }
                default:
                    print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
                }
            }
        }
        return task
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        let task = JSONTaskWithRequest(request: request) { json, response, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.Failure(error))
                    } else {
                        // TODO: Implement Error Handling
                    }
                    return
                }
                if let value = parse(json) {
                    completion(.Success(value))
                } else {
                    let error = NSError(domain: ZZHNetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                    completion(.Failure(error))
                }
            }
        }
        task.resume()
    }
}