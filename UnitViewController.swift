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
    
    var currentCurrency: Currency = .Credits {
        didSet {
            switch self.currentCurrency {
            case .Credits:
                creditsButton.setTitleColor(.white, for: .normal)
                usdButton.setTitleColor(AppColor.Dark.color, for: .normal)
            case .USD:
                creditsButton.setTitleColor(AppColor.Dark.color, for: .normal)
                usdButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    var currentLength: Measure = .Metrics {
        didSet {
            switch self.currentLength {
            case .Metrics:
                metricsButton.setTitleColor(.white, for: .normal)
                englishButton.setTitleColor(AppColor.Dark.color, for: .normal)
            case .English:
                englishButton.setTitleColor(.white, for: .normal)
                metricsButton.setTitleColor(AppColor.Dark.color, for: .normal)
            }
        }
    }
    
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
        activity.color = AppColor.Blue.color
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    lazy var tableView: SimpleTableView = {
        let tableView = SimpleTableView(headerTitle: "Loading...", labelNames: [" "," "," "," "," "], labelValues: [" "," "," "," "," "])

        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var smallestLargest: SmallestLargestView = {
        let smallestLargest = SmallestLargestView()
        smallestLargest.translatesAutoresizingMaskIntoConstraints = false
        return smallestLargest
    }()
    
    lazy var usdButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(AppColor.Dark.color, for: .normal)
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeUnits(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var creditsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Credits", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeUnits(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(AppColor.Dark.color, for: .normal)
        button.setTitle("English", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeUnits(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var metricsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Metrics", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeUnits(sender:)), for: .touchUpInside)
        return button
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
        self.navigationItem.title = "\(self.unitType.rawValue)s"
        self.navigationController?.navigationBar.tintColor = AppColor.Silver.color
        
        self.view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.size.height / 4)
            ])
        activity.startAnimating()

        self.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SmallestLargestView.height)
            ])
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        self.view.addSubview(smallestLargest)
        NSLayoutConstraint.activate([
            smallestLargest.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SmallestLargestView.height),
            smallestLargest.heightAnchor.constraint(equalToConstant: SmallestLargestView.height),
            smallestLargest.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            smallestLargest.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
            ])
        
        self.view.addSubview(creditsButton)
        NSLayoutConstraint.activate([
            creditsButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[1].centerYAnchor),
            creditsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(usdButton)
        NSLayoutConstraint.activate([
            usdButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[1].centerYAnchor),
            usdButton.rightAnchor.constraint(equalTo: self.creditsButton.leftAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(metricsButton)
        NSLayoutConstraint.activate([
            metricsButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[2].centerYAnchor),
            metricsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(englishButton)
        NSLayoutConstraint.activate([
            englishButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[2].centerYAnchor),
            englishButton.rightAnchor.constraint(equalTo: self.creditsButton.leftAnchor, constant: -SimpleTableView.offsetX),
            ])

        switch self.unitType {
        case .Character:
            self.tableView.header.text = "Loading Characters..."
            ResourcePage.fetchArray(resourceClass: Character.self) { characters in
                self.tableView.header.text = "Loading Planets..."
                ResourcePage.fetchArray(resourceClass: Planet.self) { planets in
                    for i in 0..<characters.count {
                        var character = characters[i]
                        let url = character.home
                        if let home = planets.findNameByUrl(url: url) {
                            character.home = home
                        } else {
                            character.home = "Unknown planet (\(url))"
                        }
                        self.resourceArray.append(character)
                    }
                    self.calcSmallestLargest()
                    self.currentItem = 0
                    self.pickerView.reloadAllComponents()
                    self.activity.stopAnimating()
                }
            }
        case .Vehicle:
            self.tableView.header.text = "Loading Vehicles..."
            ResourcePage.fetchArray(resourceClass: Vehicle.self) { vehicles in
                for vehicle in vehicles {
                    self.resourceArray.append(vehicle)
                }
                self.calcSmallestLargest()
                self.currentItem = 0
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        case .Starship:
            self.tableView.header.text = "Loading Starships..."
            ResourcePage.fetchArray(resourceClass: Starship.self) { starships in
                for starship in starships {
                    self.resourceArray.append(starship)
                }
                self.calcSmallestLargest()
                self.currentItem = 0
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

//MARK: - Listeners

extension UnitViewController {

    func changeUnits(sender: UIButton) {
        guard let senderTitle = sender.title(for: .normal) else {
            return
        }
        switch senderTitle {
        case "Credits": currentCurrency = .Credits
        case "USD": currentCurrency = .USD
        case "Metrics": currentLength = .Metrics
        case "English": currentLength = .English
        default: break
        }
    }
    
}


//MARK: - Helpers

extension UnitViewController {
    func smallestName(array: [Resource]) -> String {
        var smallest: Double = -1
        var smallestName: String = "n/a"
        if array.isEmpty {
            return smallestName
        }
        for i in 0..<array.count {
            if let value = array[i].measured {
                smallest = value
            }
        }
        if smallest == -1 {
            return smallestName
        }
        for element in array {
            guard let value = element.measured else {
                break
            }
            if value < smallest {
                smallest = value
                smallestName = element.name
            }
        }
        return smallestName
    }
    
    func largestName(array: [Resource]) -> String {
        var largest: Double = -1
        var largestName: String = "n/a"
        if array.isEmpty {
            return largestName
        }
        for i in 0..<array.count {
            if let value = array[i].measured {
                largest = value
            }
        }
        if largest == -1 {
            return largestName
        }
        for element in array {
            guard let value = element.measured else {
                break
            }
            if value > largest {
                largest = value
                largestName = element.name
            }
        }
        return largestName
    }
    
    func calcSmallestLargest() {
        self.smallestLargest.smallestValueLabel.text = smallestName(array: self.resourceArray)
        self.smallestLargest.largestValueLabel.text = largestName(array: self.resourceArray)
    }
}
