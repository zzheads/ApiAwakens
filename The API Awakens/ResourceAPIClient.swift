//
//  ResourceAPIClient.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

enum ResourceType: Endpoint {
    case people(String)
    case films(String)
    case starships(String)
    case vehicles(String)
    case species(String)
    case planets(String)
    
    var baseURL: URL {
        return URL(string: "https://swapi.co/api/")!
    }
    
    var path: String {
        if self.num.isEmpty {
            return "\(self.rawValue)/"
        }
        return "\(self.rawValue)/\(self.num)"
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        let request = URLRequest(url: url)
        return request
    }
    
    var num: String {
        switch self {
        case .films(let num), .people(let num), .planets(let num), .species(let num), .starships(let num), .vehicles(let num):
            return num
        }
    }
    
    var rawValue: String {
        switch self {
        case .people: return "people"
        case .films: return "films"
        case .starships: return "starships"
        case .vehicles: return "vehicles"
        case .species: return "species"
        case .planets: return "planets"
        }
    }
}

final class ResourceAPIClient: APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    init(config: URLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init() {
        self.init(config: .default)
    }
    
    func fetchResource<T>(resourceType: ResourceType, class: T.Type, completion: @escaping (APIResult<T>) -> Void) where T: JSONDecodable {
        let request = resourceType.request
        print("Request: \(request)")
        fetch(request: request, parse: { json -> T? in
            return T(JSON: json)
        }, completion: completion)
    }    
}
