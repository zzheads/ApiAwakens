//
//  Metrics.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

enum Measure {
    case Metrics
    case English
}

protocol MeasureChangeable {
    var measured: Double? { get }
    var lengthInCm: Double? { get }
    var lengthInInches: Double? { get }
    func length(inUnits: Measure) -> String
}

extension MeasureChangeable {
    var lengthInCm: Double? {
        guard let measured = self.measured else {
            return nil
        }
        return measured
    }
    var lengthInMeters: Double? {
        guard let lengthInCm = self.lengthInCm else {
            return nil
        }
        return lengthInCm / 100
    }
    var lengthInInches: Double? {
        //0,393701
        guard let heightInCm = self.lengthInCm else {
            return nil
        }
        return heightInCm * 0.393701
    }
    var lengthInFeet: Double? {
        guard let lengthInInches = self.lengthInInches else {
            return nil
        }
        return lengthInInches / 12
    }
    
    func length(inUnits: Measure) -> String {
        switch inUnits {
        case .English:
            guard let lengthInInches = self.lengthInInches, let lengthInFeet = self.lengthInFeet else {
                return "n/a"
            }
            if lengthInFeet > 1 {
                let nsString = NSString(format: "%d ft %d in", Int(lengthInFeet), Int(lengthInInches) - Int(lengthInFeet) * 12)
                return nsString as String
            } else {
                let nsString = NSString(format: "%.0f in", lengthInInches)
                return nsString as String
            }
        case .Metrics:
            guard let lengthInCm = self.lengthInCm, let lengthInMeters = self.lengthInMeters else {
                return "n/a"
            }
            if lengthInMeters > 1 {
                let nsString = NSString(format: "%d m %d cm", Int(lengthInMeters), Int(lengthInCm) - Int(lengthInMeters) * 100)
                return nsString as String
            }
            let nsString = NSString(format: "%.0f cm", lengthInCm)
            return nsString as String
        }
    }
}
