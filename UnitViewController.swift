//
//  UnitViewController.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
    let unitType: UnitType
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
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
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = AppColor.Black.color
        tableView.separatorColor = .gray
        
        switch self.unitType {
        case .Character:
            print("\n\n\nCHARACTERS: ")
            ResourcePage.fetchArray(resourceClass: Character.self) { characters in
                for character in characters {
                    print("\(character.name)")
                    self.resourceArray.append(character)
                }
                self.tableView.reloadData()
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
                self.tableView.reloadData()
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
                self.tableView.reloadData()
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -- pickerView
    
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
        
    }
    
    //MARK: -- tableView
    
    //MARK: - TableView DataSource
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let homeLabel = UILabel()
        homeLabel.text = "Homeworld"
        let makeLabel = UILabel()
        homeLabel.text = "Make"
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.contentView.addSubview(homeLabel)
            NSLayoutConstraint.activate([
                homeLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                homeLabel.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
                homeLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                homeLabel.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor)
                ])
        case (0, 1):
            cell.contentView.addSubview(makeLabel)
            NSLayoutConstraint.activate([
                makeLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                makeLabel.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
                makeLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                makeLabel.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor)
                ])
            
        default:
            break
        }
        
        return cell
    }


    //MARK: - TableView Delegates
}
