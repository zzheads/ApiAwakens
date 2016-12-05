//
//  Starship.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Starship: Resource, CurrencyChangeable, MeasureChangeable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: String
    var labelNames: [String] {
        return ["Make", "Cost", "Length", "Class", "Crew"]
    }
    var labelValues: [String] {
        return [self.make, self.cost, self.length, self.starshipClass, self.crew]
    }
    
    init(name: String, make: String, cost: String, length: String, starshipClass: String, crew: String){
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
    }
    
    var measured: Double? {
        if let measured = Double(length.replacingOccurrences(of: ",", with: "")) {
            return measured * 100
        }
        return nil
    }
    
    func values(currency: Currency, measure: Measure) -> [String] {
        return [self.make, cost(inCurrency: currency), length(inUnits: measure), self.starshipClass, self.crew]
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
        self.init(name: name, make: make, cost: cost, length: length, starshipClass: starshipClass, crew: crew)
    }
}
