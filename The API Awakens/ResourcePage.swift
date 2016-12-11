//
//  CharacterArray.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct ResourcePage {
    let count: Int
    let next: String?
    let previous: String?
    var results: [JSON] = []
}

extension ResourcePage: JSONDecodable {
    init?(JSON: JSON) {
        guard
        let count = JSON["count"] as? Int,
        let results = JSON["results"] as? [JSON]
            else {
                return nil
        }
        let next = JSON["next"] as? String
        let previous = JSON["previous"] as? String

        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }

    static func fetchArray<T>(resourceClass: T.Type, progressTo: @escaping (Float) -> Void, labelText: @escaping (String) -> Void, completion: @escaping ([T]) -> Void) where T: JSONDecodable {
        let apiClient = ResourceAPIClient()
        var pageNumber = 1
        var resultArray: [T] = []
        
        progressTo(0)
        labelText(" 0%...")
        
        func listPage(completion: @escaping ([T]) -> Void) {
            
            var resourceType: ResourceType = .films("")
            
            if resourceClass == Character.self {
                resourceType = ResourceType.people("?page=\(pageNumber)")
            }
            if resourceClass == Vehicle.self {
                resourceType = ResourceType.vehicles("?page=\(pageNumber)")
            }
            if resourceClass == Starship.self {
                resourceType = ResourceType.starships("?page=\(pageNumber)")
            }
            if resourceClass == Planet.self {
                resourceType = ResourceType.planets("?page=\(pageNumber)")
            }
            
            apiClient.fetchResource(resourceType: resourceType, class: ResourcePage.self) { result in
                switch result {
                case .Success(let resourcePage):
                    for jsonElement in resourcePage.results {
                        if let element = T(JSON: jsonElement) {
                            resultArray.append(element)
                        } else {
                        }
                    }
                    if resourcePage.next != nil {
                        //print("PageNumber: \(pageNumber), ResourcePage: count: \(resourcePage.count)")
                        pageNumber += 1
                        var percentage = Float(pageNumber * 10) / Float(resourcePage.count)
                        if percentage > 1 {
                            percentage = 1.0
                        }
                        progressTo(percentage)
                        labelText("\(Int(percentage * 100))%...")
                        listPage(completion: completion)
                    } else {
                        completion(resultArray)
                        return
                    }
                case .Failure(let error): print("\(error.localizedDescription)")
                }
            }
        }
        
        listPage(completion: completion)
    }
}

