//
//  Vehicle.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Vehicle: Resource, CurrencyChangeable, MeasureChangeable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    var labelNames: [String]
    var labelValues: [String]
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String){
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
        self.labelNames = ["Make", "Cost", "Length", "Class", "Crew"]
        self.labelValues = [self.make, self.cost, self.length, self.vehicleClass, self.crew]
    }
    
    var measured: Double? {
        if let measured = Double(length.replacingOccurrences(of: ",", with: "")) {
            return measured * 100
        }
        return nil
    }
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
        self.init(name: name, make: make, cost: cost, length: length, vehicleClass: vehicleClass, crew: crew)
    }
}
