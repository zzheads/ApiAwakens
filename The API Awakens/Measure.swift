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
    var lengthInYards: Double? {
        guard let lengthInInches = self.lengthInInches else {
            return nil
        }
        return lengthInInches / 36
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
            guard let lengthInInches = self.lengthInInches, let lengthInYards = self.lengthInYards, let lengthInFeet = self.lengthInFeet else {
                return "n/a"
            }
            if lengthInYards > 0 {
                let nsString = NSString(format: "%d yd", Int(lengthInYards))
                return nsString as String
            }
            if lengthInFeet > 0 {
                let nsString = NSString(format: "%d ft %d in", Int(lengthInFeet), Int(lengthInInches) - Int(lengthInFeet) * 12)
                return nsString as String
            } else {
                let nsString = NSString(format: "%d in", lengthInInches)
                return nsString as String
            }
        case .Metrics:
            guard let lengthInCm = self.lengthInCm, let lengthInMeters = self.lengthInMeters else {
                return "n/a"
            }
            if lengthInMeters > 2 {
                let nsString = NSString(format: "%d m", lengthInMeters)
                return nsString as String
            }
            let nsString = NSString(format: "%d cm", lengthInCm)
            return nsString as String
        }
    }
}
