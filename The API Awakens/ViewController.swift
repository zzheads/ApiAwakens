//
//  ViewController.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let widthScreen = UIScreen.main.bounds.size.width
    static let heightScreen = UIScreen.main.bounds.size.height
    
    lazy var buttons: [UnitType: UIButton] = [:]

    lazy var topLine: Line = {
        return Line(xStart: Int(widthScreen / 20), xEnd: Int(widthScreen * 19 / 20), y: Int(heightScreen * (0.5 + UnitType.offset) / 2), color: .gray)
    }()
    lazy var bottomLine: Line = {
        return Line(xStart: Int(widthScreen / 20), xEnd: Int(widthScreen * 19 / 20), y: Int(heightScreen * (1.5 - UnitType.offset) / 2), color: .gray)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.Black.color
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)

        for type in UnitType.allTypes {
            let button = UIButton()
            button.setBackgroundImage(type.image, for: .normal)
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: type.centerYAnchor)
                ])
            button.setTitleColor(.clear, for: .normal)
            button.setTitle(type.rawValue, for: .normal)
            buttons.updateValue(button, forKey: type)
        }

        self.view.addSubview(topLine)
        self.view.addSubview(bottomLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonPressed(sender: UIButton) {
        guard let typeName = sender.title(for: .normal), let unitType = UnitType(rawValue: typeName) else {
            return
        }
        let unitViewController = UnitViewController(unitType: unitType)
        self.navigationController?.pushViewController(unitViewController, animated: true)
//        let navigationController = UINavigationController(rootViewController: unitViewController)
//        self.present(navigationController, animated: true, completion: nil)
    }
}



