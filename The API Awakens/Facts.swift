//
//  Facts.swift
//  The API Awakens
//
//  Created by Alexey Papin on 06.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

typealias FactCalculateFunction = ([Resource]) -> String


// MARK: - Facts Functions here

func smallestName(array: [Resource]) -> String {
    var smallest: Double = -1
    var smallestName: String = "n/a"
    if array.isEmpty {
        return smallestName
    }
    for i in 0..<array.count {
        if let value = array[i].measured {
            smallest = value
        }
    }
    if smallest == -1 {
        return smallestName
    }
    for element in array {
        guard let value = element.measured else {
            break
        }
        if value < smallest {
            smallest = value
            smallestName = element.name
        }
    }
    return smallestName
}

func largestName(array: [Resource]) -> String {
    var largest: Double = -1
    var largestName: String = "n/a"
    if array.isEmpty {
        return largestName
    }
    for i in 0..<array.count {
        if let value = array[i].measured {
            largest = value
        }
    }
    if largest == -1 {
        return largestName
    }
    for element in array {
        guard let value = element.measured else {
            break
        }
        if value > largest {
            largest = value
            largestName = element.name
        }
    }
    return largestName
}

func count(array: [Resource]) -> String {
    return "\(array.count)"
}

func mostExpensive(array: [Resource]) -> String {
    var expensive: Double = -1
    var expensiveName: String = "n/a"
    if array.isEmpty {
        return expensiveName
    }
    for i in 0..<array.count {
        if let value = array[i].costInCredits {
            expensive = value
        }
    }
    if expensive == -1 {
        return expensiveName
    }
    for element in array {
        guard let value = element.costInCredits else {
            break
        }
        if value > expensive {
            expensive = value
            expensiveName = element.name
        }
    }
    return expensiveName
}

func cheapest(array: [Resource]) -> String {
    var expensive: Double = -1
    var expensiveName: String = "n/a"
    if array.isEmpty {
        return expensiveName
    }
    for i in 0..<array.count {
        if let value = array[i].costInCredits {
            expensive = value
        }
    }
    if expensive == -1 {
        return expensiveName
    }
    for element in array {
        guard let value = element.costInCredits else {
            break
        }
        if value < expensive {
            expensive = value
            expensiveName = element.name
        }
    }
    return expensiveName
}

func abbreaviatureABY(resource: [Resource]) -> String {
    return "After Battle of Yavin"
}

func abbreaviatureBBY(resource: [Resource]) -> String {
    return "Before Battle of Yavin"
}


struct Facts {
    static let facts: [String: FactCalculateFunction] = [
        "Smallest": smallestName(array: ),
        "Largest": largestName(array: ),
        "Total items": count(array: ),
        "Most expensive": mostExpensive(array: ),
        "Cheapest": cheapest(array: ),
        "ABY means": abbreaviatureABY(resource: ),
        "BBY means": abbreaviatureBBY(resource: )
    ]
}
