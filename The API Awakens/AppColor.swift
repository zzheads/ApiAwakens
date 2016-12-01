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
    
    var color: UIColor {
        switch self {
        case .Black: return UIColor(red: 55/255.0, green: 58/255.0, blue: 60/255.0, alpha: 1.0)
        }
    }
}
