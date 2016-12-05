//
//  Currency.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

enum Currency {
    case Credits
    case USD
}

protocol CurrencyChangeable {
    var cost: String { get }
    var costInCredits: Double? { get }
    var costInUSD: Double? { get }
    func cost(inCurrency: Currency) -> String
}

extension CurrencyChangeable {
    
    //      MARK: -Translate Galaxy Credits in USDollars
    //      Source: http://www.swtor.com/community/showthread.php?t=442915
    //      Now, we have picked the Sliders which generally sell for 6.7 Galactic Credit Standard (GCS),
    //      as they generally seem to use the same type of
    //      food stock as the MacD [s]bread and butter[/s] Burger.
    //      In the US the Big-Mac on average sell for 4.2 dollars in 2012. (8)
    //      the price of a Big Mac was 6.7 GCS in the Galaxy (At Dex's Diner)
    //      the price of a Big Mac was 4.2 USD in the United States (Varies by Store)
    //      the implied purchasing power parity was 1.6 GCS to 1 USD , that is 6.7/4.2 = 1.59
    //      In the Euro-zone the Big-Mac price varies, but on average sell for 4.43 USD.
    
    var costInCredits: Double? {
        if let costInCredits = Double(self.cost.replacingOccurrences(of: ",", with: "")) {
            return costInCredits
        }
        return nil
    }
    
    var costInUSD: Double? {
        guard let costInCredits = self.costInCredits else {
            return nil
        }
        return costInCredits * 4.2 / 6.7
    }
    
    func cost(inCurrency: Currency) -> String {
        switch inCurrency {
        case .Credits:
            guard let cost = costInCredits else {
                return "n/a"
            }
            return NSString(format: "%.0f creds", cost) as String
        case .USD:
            guard let cost = costInUSD else {
                return "n/a"
            }
            return NSString(format: "$ %.0f", cost) as String
        }
    }
}
