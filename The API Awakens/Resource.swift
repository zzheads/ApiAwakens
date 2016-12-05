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
    var labelNames: [String] { get set }
    var labelValues: [String] { get set }
    var measured: Double? { get }
}
