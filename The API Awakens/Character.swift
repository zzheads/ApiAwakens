//
//  Character.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Character: Resource, MeasureChangeable, URLType {
    let name: String
    let born: String
    var home: String
    let height: String
    let eyes: String
    let hair: String
    let url: String
    var vehicles: [String]?
    var starships: [String]?
    
    var labelNames: [String] {
        return CharacterKeys.labelNames
    }
    
    var driveVehicles: String {
        var drive = ""
        if let vehicles = self.vehicles {
            for vehicle in vehicles {
                drive += "\(vehicle), "
            }
        }
        if drive.characters.count > 2 {
            // get rid of last 2 chars (", ")
            let truncated = String(drive.characters.dropLast().dropLast())
            return truncated
        }
        return drive
    }

    var driveShips: String {
        var drive = ""
        if let starships = self.starships {
            for starship in starships {
                drive += "\(starship), "
            }
        }
        if drive.characters.count > 2 {
            // get rid of last 2 chars (", ")
            let truncated = String(drive.characters.dropLast().dropLast())
            return truncated
        }
        return drive
    }

    
    init(name: String, born: String, home: String, height: String, eyes: String, hair: String, url: String, starships: [String]?, vehicles: [String]?){
        self.name = name
        self.born = born
        self.home = home
        self.height = height
        self.eyes = eyes
        self.hair = hair
        self.url = url
        self.starships = starships
        self.vehicles = vehicles
    }
    
    var measured: Double? {
        if let measured = Double(height.replacingOccurrences(of: ",", with: "")) {
            return measured
        }
        return nil
    }

    func values(currency: Currency, measure: Measure) -> [String] {
        return [self.born, self.home, length(inUnits: measure), self.eyes, self.hair, self.driveVehicles, self.driveShips]
    }
}

extension Character: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON[CharacterKeys.name.rawValue] as? String,
            let born = JSON[CharacterKeys.birth_year.rawValue] as? String,
            let home = JSON[CharacterKeys.homeworld.rawValue] as? String,
            let height = JSON[CharacterKeys.height.rawValue] as? String,
            let eyes = JSON[CharacterKeys.eye_color.rawValue] as? String,
            let hair = JSON[CharacterKeys.hair_color.rawValue] as? String,
            let url = JSON[CharacterKeys.url.rawValue] as? String
            else {
                return nil
        }
        let starships = JSON[CharacterKeys.starships.rawValue] as? [String]
        let vehicles = JSON[CharacterKeys.vehicles.rawValue] as? [String]
        self.init(name: name, born: born, home: home, height: height, eyes: eyes, hair: hair, url: url, starships: starships, vehicles: vehicles)
    }
}
