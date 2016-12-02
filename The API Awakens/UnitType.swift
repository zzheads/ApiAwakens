//
//  UnitType.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

let height = UIScreen.main.bounds.size.height

enum UnitType: String {
    case Character
    case Vehicle
    case Starship
    
    var centerYAnchor: CGFloat {
        switch self {
        case .Character: return UnitType.offset * height
        case .Vehicle: return 0.5 * height
        case .Starship: return (1.0 - UnitType.offset) * height
        }
    }
    
    var image: UIImage {
        return UIImage(named: self.rawValue.lowercased())!
    }
    
    var resourceType: ResourceType {
        switch self {
        case .Character: return .people(nil)
        case .Starship: return .starships(nil)
        case .Vehicle: return .vehicles(nil)
        }
    }
    
    var resourseKeys: [String] {
        switch self {
        case .Character: return ["birth_year", "homeworld", "height", "eye_color", "hair_color"]
        case .Starship: return ["created", "cost_in_credits", "length", "starship_class", "crew"]
        case .Vehicle: return ["created", "cost_in_credits", "length", "vehicle_class", "crew"]
        }
    }
    
    static let offset: CGFloat = 0.2
    static let allTypes: [UnitType] = [UnitType.Character, UnitType.Vehicle, UnitType.Starship]
}

enum VehicleKeys: String {
    case url
    case pilots
    case crew 
    case name
    case films
    case model
    case cost_in_credits
    case cargo_capacity
    case max_atmosphering_speed
    case edited
    case created
    case passengers
    case vehicle_class
    case manufacturer
    case consumables
    case length
    
    var keysToShow: [VehicleKeys] {
        return [.created, .cost_in_credits, .length, .vehicle_class, .crew]
    }
}

enum StarshipKeys: String {
    case length
    case pilots
    case crew
    case name
    case films
    case MGLT
    case model
    case cost_in_credits
    case cargo_capacity
    case starship_class
    case max_atmosphering_speed
    case hyperdrive_rating
    case edited
    case created
    case passengers
    case manufacturer
    case consumables
    case url

    var keysToShow: [StarshipKeys] {
        return [.created, .cost_in_credits, .length, .starship_class, .crew]
    }
}

enum CharacterKeys: String {
    case vehicles
    case name
    case homeworld
    case films
    case mass
    case gender
    case eye_color
    case height
    case hair_color
    case skin_color
    case starships
    case birth_year
    case species
    case url
    
    var keysToShow: [CharacterKeys] {
        return [.birth_year, .homeworld, .height, .eye_color, .hair_color]
    }
}
