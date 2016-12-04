//
//  AppColor.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

enum AppColor {
    case Black
    case Blue
    case Silver
    case Dark
    
    var color: UIColor {
        switch self {
        case .Black: return UIColor(red: 55/255.0, green: 58/255.0, blue: 60/255.0, alpha: 1.0)
        case .Blue: return UIColor(red: 120/255.0, green: 202/255.0, blue: 250/255.0, alpha: 1.0)
        case .Silver: return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        case .Dark: return UIColor(red: 96/255.0, green: 96/255.0, blue: 97/255.0, alpha: 1.0)
        }
    }
}
