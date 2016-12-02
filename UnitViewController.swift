//
//  UnitViewController.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController {
    let unitType: UnitType

    init(unitType: UnitType) {
        self.unitType = unitType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.Black.color
        navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationItem.title = "\(self.unitType.rawValue)"
        
        let resApiClient = ResourceAPIClient()
        resApiClient.fetchSchema(for: self.unitType.resourceType) { result in
            switch result {
            case .Success(let schema):
                print("")
                print("Title: \(schema.title.uppercased())")
                print("Description: \(schema.description)")
                print("Required: \(schema.required)")
                print("--------------------------------------------------")
                for property in schema.properties {
                    print("\(property.key): \(property.value.type)")
                }
            case .Failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        
        let charApiClient = ResAPIClient()
        charApiClient.fetchCharacter(for: .people(nil)) { result in
            switch result {
            case .Success(let character):
                charApiClient.fetchPlanet(for: URLRequest(url: URL(string: character.home.replacingOccurrences(of: "http", with: "https"))!)) { planetResult in
                    switch planetResult {
                    case .Success(let planet):
                        print("\n\n\n")
                        print("Name: \(character.name.uppercased())")
                        print("Born: \(character.born.capitalized)")
                        print("Home: \(planet.name.capitalized)")
                        print("Height: \(character.height.capitalized)")
                        print("Eyes: \(character.eyes.capitalized)")
                        print("Hair: \(character.hair.capitalized)")
                    case .Failure(let error):
                        print("\(error.localizedDescription)")
                    }
                }
            case .Failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
