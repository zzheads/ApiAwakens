//
//  Starship.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Starship: Resource {
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: String
    let labelNames: [String] = ["Make", "Cost", "Length", "Class", "Crew"]
    var labelValues: [String]
    
    var measured: Double {
        if let measured = Double(length.replacingOccurrences(of: ",", with: "")) {
            return measured * 100
        }
        return 0
    }
    
    var costInCredits: Double? {
        if let costInCredits = Double(cost.replacingOccurrences(of: ",", with: "")) {
            return costInCredits
        }
        return nil
    }
}

extension Starship: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON["name"] as? String,
            let make = JSON["manufacturer"] as? String,
            let cost = JSON["cost_in_credits"] as? String,
            let length = JSON["length"] as? String,
            let starshipClass = JSON["starship_class"] as? String,
            let crew = JSON["crew"] as? String
            else {
                return nil
        }
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
        self.labelValues = [make, cost, length, starshipClass, crew]
    }
}
