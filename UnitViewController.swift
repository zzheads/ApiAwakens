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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
