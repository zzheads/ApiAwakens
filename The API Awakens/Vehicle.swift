//
//  Vehicle.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Vehicle: Resource {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    let labelNames: [String] = ["Make", "Cost", "Length", "Class", "Crew"]
    var labelValues: [String]
}

extension Vehicle: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON["name"] as? String,
            let make = JSON["manufacturer"] as? String,
            let cost = JSON["cost_in_credits"] as? String,
            let length = JSON["length"] as? String,
            let vehicleClass = JSON["vehicle_class"] as? String,
            let crew = JSON["crew"] as? String
            else {
                return nil
        }
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
        self.labelValues = [make, cost, length, vehicleClass, crew]
    }
}
