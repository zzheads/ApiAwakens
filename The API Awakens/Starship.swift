//
//  Starship.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Starship: Resource, CurrencyChangeable, MeasureChangeable, URLType {
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: String
    let url: String
    var pilots: [String]?
    var labelNames: [String] {
        return StarshipKeys.labelNames
    }
    var labelValues: [String] {
        return [self.make, self.cost, self.length, self.starshipClass, self.crew]
    }
    
    init(name: String, make: String, cost: String, length: String, starshipClass: String, crew: String, url: String, pilots: [String]?){
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
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
        return [self.make.capitalized, cost(inCurrency: currency), length(inUnits: measure), self.starshipClass.capitalized, self.crew.capitalized, self.pilotNames]
    }
}

extension Starship: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON[StarshipKeys.name.rawValue] as? String,
            let make = JSON[StarshipKeys.manufacturer.rawValue] as? String,
            let cost = JSON[StarshipKeys.cost_in_credits.rawValue] as? String,
            let length = JSON[StarshipKeys.length.rawValue] as? String,
            let starshipClass = JSON[StarshipKeys.starship_class.rawValue] as? String,
            let crew = JSON[StarshipKeys.crew.rawValue] as? String,
            let url = JSON[StarshipKeys.url.rawValue] as? String
            else {
                return nil
        }
        let pilots = JSON[StarshipKeys.pilots.rawValue] as? [String]
        self.init(name: name, make: make, cost: cost, length: length, starshipClass: starshipClass, crew: crew, url: url, pilots: pilots)
    }
}
