//
//  StarshipKeys.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

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
    
    var labelName: String {
        switch self {
        case .length: return "Length"
        case .pilots: return "Pilots"
        case .crew: return "Crew"
        case .cost_in_credits: return "Cost"
        case .starship_class: return "Class"
        case .manufacturer: return "Make"
        default: return self.rawValue.uppercased()
        }
    }
    
    static var labelValues: [StarshipKeys] {
        return [.manufacturer, .cost_in_credits, .length, .starship_class, .crew, .pilots]
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
