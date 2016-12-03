//
//  Character.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Character: Resource {
    let name: String
    let born: String
    let home: String
    let height: String
    let eyes: String
    let hair: String
}

extension Character: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON[CharacterKeys.name.rawValue] as? String,
            let born = JSON[CharacterKeys.birth_year.rawValue] as? String,
            let home = JSON[CharacterKeys.homeworld.rawValue] as? String,
            let height = JSON[CharacterKeys.height.rawValue] as? String,
            let eyes = JSON[CharacterKeys.eye_color.rawValue] as? String,
            let hair = JSON[CharacterKeys.hair_color.rawValue] as? String
            else {
                return nil
        }
        self.name = name
        self.born = born
        self.home = home
        self.height = height
        self.eyes = eyes
        self.hair = hair
    }    
}
