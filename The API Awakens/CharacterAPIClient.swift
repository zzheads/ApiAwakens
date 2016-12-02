//
//  CharacterAPIClient.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

extension ResourceType {
    var pathToResource: String {
        if let number = self.number {
            return ("\(self.rawValue)/\(number)/")
        } else {
            return ("\(self.rawValue)")
        }
    }
    
    var requestToResource: URLRequest {
        let url = URL(string: pathToResource, relativeTo: baseURL)!
        return URLRequest(url: url)
    }
}

final class ResAPIClient: APIClient {
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
    
    func fetchCharacter(for resourceType: ResourceType, completion: @escaping (APIResult<Character>) -> Void) {
        let request = resourceType.requestToResource
        fetch(request: request, parse: { json -> Character? in
            return Character(JSON: json)
        }, completion: completion)
    }

    func fetchPlanet(for request: URLRequest, completion: @escaping (APIResult<Planet>) -> Void) {
        fetch(request: request, parse: { json -> Planet? in
            return Planet(JSON: json)
        }, completion: completion)
    }
}
