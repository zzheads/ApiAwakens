//
//  ResourceAPIClient.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

enum ResourceType: Endpoint {
    case people(Int?)
    case films(Int?)
    case starships(Int?)
    case vehicles(Int?)
    case species(Int?)
    case planets(Int?)
    
    var baseURL: URL {
        return URL(string: "https://swapi.co/api/")!
    }
    
    var path: String {
        return "\(self.rawValue)/schema"
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        let request = URLRequest(url: url)
        return request
    }
    
    var number: Int? {
        switch self {
        case .films(let number), .people(let number), .planets(let number), .species(let number), .starships(let number), .vehicles(let number):
            return number
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
    
    func fetchSchema(for resourceType: ResourceType, completion: @escaping (APIResult<ResourceSchema>) -> Void) {
        let request = resourceType.request
        fetch(request: request, parse: { json -> ResourceSchema? in
            return ResourceSchema(JSON: json)
        }, completion: completion)
    }    
}
