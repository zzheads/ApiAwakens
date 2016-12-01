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
    
    static let offset: CGFloat = 0.2
    static let allTypes: [UnitType] = [UnitType.Character, UnitType.Vehicle, UnitType.Starship]
}
