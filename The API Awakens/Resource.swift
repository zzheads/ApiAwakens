//
//  Resource.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol Resource {
    var name: String { get }
    var labelNames: [String] { get }
    var measured: Double? { get }
    var costInCredits: Double? { get }
    
    func values(currency: Currency, measure: Measure) -> [String]
}
