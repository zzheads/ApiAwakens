//
//  CharacterKeys.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

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
    
    var labelName: String {
        switch self {
        case .vehicles: return "Vehicles"
        case .homeworld: return "Home"
        case .eye_color: return "Eyes"
        case .height: return "Height"
        case .hair_color: return "Hair"
        case .starships: return "Ships"
        case .birth_year: return "Born"
        default: return self.rawValue.uppercased()
        }
    }
    
    static var labelValues: [CharacterKeys] {
        return [.birth_year, .homeworld, .height, .eye_color, .hair_color, .vehicles, .starships]
    }
    
    static var labelNames: [String] {
        var labels: [String] = []
        for value in labelValues {
            labels.append(value.labelName)
        }
        return labels
    }
    
    static var emptyFields: [String] {
        var labels: [String] = []
        for _ in labelValues {
            labels.append(" ")
        }
        return labels
    }
}
