//
//  URLType.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol URLType {
    var url: String { get }
    var name: String { get }
}

extension Array where Element: URLType {
    func findNameByUrl(url: String) -> String? {
        for planet in self {
            if planet.url == url {
                return planet.name
            }
        }
        return nil
    }
}
