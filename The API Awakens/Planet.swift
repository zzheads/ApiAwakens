//
//  Planet.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol PlanetType {
    var url: String { get }
    var name: String { get }
}

struct Planet: Resource, PlanetType {
    let name: String
    let url: String
    var labelNames: [String] {
        return ["Name", "URL"]
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    var measured: Double? {
        return nil
    }
    
    func values(currency: Currency, measure: Measure) -> [String] {
        return [self.name, self.url]
    }
}

extension Planet: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON["name"] as? String,
            let url = JSON["url"] as? String
            else {
                return nil
        }
        self.init(name: name, url: url)
    }
}

extension Array where Element: PlanetType {
    func findNameByUrl(url: String) -> String? {
        for planet in self {
            if planet.url == url {
                return planet.name
            }
        }
        return nil
    }
}
