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

    var currentItem = 0 {
        didSet {
            if (!resourceArray.isEmpty) {
                tableView.header.text = resourceArray[currentItem].name
                for i in 0..<resourceArray[currentItem].labelNames.count {
                    tableView.labelNames[i].text = resourceArray[currentItem].labelNames[i]
                    tableView.labelValues[i].text = resourceArray[currentItem].labelValues[i]
                }
            }
        }
    }
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.isHidden = true
        activity.hidesWhenStopped = true
        return activity
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var tableView: SimpleTableView = {
        let tableView = SimpleTableView(headerTitle: "Loading...", labelNames: ["Loading...", "Loading...", "Loading...", "Loading...", "Loading..."], labelValues: [" ", " ", " ", " ", " "])
        return tableView
    }()

    var resourceArray: [Resource] = []
    
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
        
        self.view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        activity.startAnimating()

        self.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        switch self.unitType {
        case .Character:
            print("\n\n\nCHARACTERS: ")
            ResourcePage.fetchArray(resourceClass: Character.self) { characters in
                for character in characters {
                    print("\(character.name)")
                    self.resourceArray.append(character)
                }
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        case .Vehicle:
            print("\n\n\nVEHICLES: ")
            ResourcePage.fetchArray(resourceClass: Vehicle.self) { vehicles in
                for vehicle in vehicles {
                    print("\(vehicle.name)")
                    self.resourceArray.append(vehicle)
                }
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        case .Starship:
            print("\n\n\nSTARSHIPS: ")
            ResourcePage.fetchArray(resourceClass: Starship.self) { starships in
                for starship in starships {
                    print("\(starship.name)")
                    self.resourceArray.append(starship)
                }
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: -- PICKER VIEW

extension UnitViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - PickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return resourceArray.count
    }
    
    //MARK: - PickerView Delegates
        
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: resourceArray[row].name, attributes: [NSForegroundColorAttributeName : UIColor.black])
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentItem = row
    }
}
