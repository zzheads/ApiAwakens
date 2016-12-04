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
    let labelNames = ["Name"]
    var labelValues: [String]
    var measured: Double {
        return 0
    }
    var costInCredits: Double? {
        return nil
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
        self.name = name
        self.url = url
        self.labelValues = [name]
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
