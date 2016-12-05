//
//  VehicleKeys.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

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
    
    var labelName: String {
        switch self {
        case .length: return "Length"
        case .pilots: return "Pilots"
        case .crew: return "Crew"
        case .cost_in_credits: return "Cost"
        case .vehicle_class: return "Class"
        case .manufacturer: return "Make"
        default: return self.rawValue.uppercased()
        }
    }
    
    static var labelValues: [VehicleKeys] {
        return [.manufacturer, .cost_in_credits, .length, .vehicle_class, .crew, .pilots]
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
