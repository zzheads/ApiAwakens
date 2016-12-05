//
//  FastFact.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

typealias FactCalculateFunction = ([Resource]) -> String

protocol FastFactType {
    var question: String { get }
    var answer: FactCalculateFunction { get }
}
