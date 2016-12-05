//
//  Vehicle.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Vehicle: Resource, CurrencyChangeable, MeasureChangeable, URLType {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    let url: String
    var pilots: [String]?
    var labelNames: [String] {
        return VehicleKeys.labelNames
    }
    var labelValues: [String] {
        return [self.make, self.cost, self.length, self.vehicleClass, self.crew]
    }
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String, url: String, pilots: [String]?){
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
        self.url = url
        self.pilots = pilots
    }
    
    var measured: Double? {
        if let measured = Double(length.replacingOccurrences(of: ",", with: "")) {
            return measured * 100
        }
        return nil
    }
    
    var pilotNames: String {
        var pilotNames = ""
        if let pilots = self.pilots {
            for pilot in pilots {
                pilotNames += "\(pilot), "
            }
        }
        if pilotNames.characters.count > 2 {
            // get rid of last 2 chars (", ")
            let truncated = String(pilotNames.characters.dropLast().dropLast())
            return truncated
        }
        return pilotNames
    }
    
    func values(currency: Currency, measure: Measure) -> [String] {
        return [self.make.capitalized, cost(inCurrency: currency), length(inUnits: measure), self.vehicleClass.capitalized, self.crew.capitalized, self.pilotNames]
    }
}

extension Vehicle: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON[VehicleKeys.name.rawValue] as? String,
            let make = JSON[VehicleKeys.manufacturer.rawValue] as? String,
            let cost = JSON[VehicleKeys.cost_in_credits.rawValue] as? String,
            let length = JSON[VehicleKeys.length.rawValue] as? String,
            let vehicleClass = JSON[VehicleKeys.vehicle_class.rawValue] as? String,
            let crew = JSON[VehicleKeys.crew.rawValue] as? String,
            let url = JSON[VehicleKeys.url.rawValue] as? String
            else {
                return nil
        }
        let pilots = JSON[VehicleKeys.pilots.rawValue] as? [String]
        self.init(name: name, make: make, cost: cost, length: length, vehicleClass: vehicleClass, crew: crew, url: url, pilots: pilots)
    }
}
