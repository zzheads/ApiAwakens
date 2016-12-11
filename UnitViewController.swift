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
            currentItem += 0
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
            currentItem += 0
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
                    tableView.labelValues[i].text = resourceArray[currentItem].values(currency: currentCurrency, measure: currentLength)[i]
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
    
    lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = AppColor.Silver.color
        progress.tintColor = AppColor.Blue.color
        return progress
    }()
    
    func progressTo(value: Float) {
        progress.setProgress(value, animated: true)
    }
    
    var currentLabelText: String = "" {
        didSet {
            statusLabel.text = currentLabelText
        }
    }
    
    func labelText(text: String) {
        statusLabel.text = "\(currentLabelText) \(text)"
    }
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = AppColor.Blue.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let tableView: SimpleTableView

    lazy var quickFactsBar: QuickFactsBar = {
        let quickFactsBar = QuickFactsBar(resource: self.resourceArray)
        quickFactsBar.translatesAutoresizingMaskIntoConstraints = false
        return quickFactsBar
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
        switch unitType {
        case .Character: self.tableView = SimpleTableView(headerTitle: "", labelNames: CharacterKeys.emptyFields, labelValues: CharacterKeys.emptyFields)
        case .Starship: self.tableView = SimpleTableView(headerTitle: "", labelNames: StarshipKeys.emptyFields, labelValues: StarshipKeys.emptyFields)
        case .Vehicle: self.tableView = SimpleTableView(headerTitle: "", labelNames: VehicleKeys.emptyFields, labelValues: VehicleKeys.emptyFields)
        }
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.size.height / 4)
            ])
        
        self.view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activity.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: activity.bounds.size.height)
            ])
        activity.startAnimating()
        
        self.view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progress.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2),
            //progress.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 100),
            progress.topAnchor.constraint(equalTo: activity.bottomAnchor, constant: activity.bounds.size.height / 2)
            ])
        progress.setProgress(0, animated: true)

        self.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.size.height * 2 / 3),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -QuickFactsBar.height)
            ])
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 80),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        self.view.addSubview(quickFactsBar)
        NSLayoutConstraint.activate([
            quickFactsBar.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -QuickFactsBar.height),
            quickFactsBar.heightAnchor.constraint(equalToConstant: QuickFactsBar.height),
            quickFactsBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            quickFactsBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
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
            hideAll()
            self.currentLabelText = "Loading Characters"
            ResourcePage.fetchArray(resourceClass: Character.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { characters in
                self.currentLabelText = "Loading Planets"
                ResourcePage.fetchArray(resourceClass: Planet.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { planets in
                    self.currentLabelText = "Loading Vehicles"
                    ResourcePage.fetchArray(resourceClass: Vehicle.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { vehicles in
                        self.currentLabelText = "Loading Starships"
                        ResourcePage.fetchArray(resourceClass: Starship.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { starships in
                            for i in 0..<characters.count {
                                var character = characters[i]
                                let urlPlanet = character.home
                                if let home = planets.findNameByUrl(url: urlPlanet) {
                                    character.home = home.capitalized
                                } else {
                                    character.home = "Unknown planet (\(urlPlanet))"
                                }
                                
                                if let characterVehicles = character.vehicles {
                                    var vehicleNames: [String] = []
                                    for urlVehicle in characterVehicles {
                                        if let vehicleName = vehicles.findNameByUrl(url: urlVehicle) {
                                            vehicleNames.append(vehicleName.capitalized)
                                        } else {
                                            vehicleNames.append("Unknown vehicle (\(urlVehicle))")
                                        }
                                    }
                                    character.vehicles = vehicleNames
                                }
                                
                                if let characterStarships = character.starships {
                                    var starshipNames: [String] = []
                                    for urlStarship in characterStarships {
                                        if let starshipName = starships.findNameByUrl(url: urlStarship) {
                                            starshipNames.append(starshipName.capitalized)
                                        } else {
                                            starshipNames.append("Unknown starship (\(urlStarship))")
                                        }
                                    }
                                    character.starships = starshipNames
                                }
                                
                                self.resourceArray.append(character)
                            }
                            self.showAll()
                            self.currentItem = 0
                            self.pickerView.reloadAllComponents()
                            self.activity.stopAnimating()
                            self.quickFactsBar.resource = self.resourceArray
                            self.quickFactsBar.nextFact(sender: nil)
                        }
                    }
                }
            }
        case .Vehicle:
            hideAll()
            self.currentLabelText = "Loading Vehicles"
            ResourcePage.fetchArray(resourceClass: Vehicle.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { vehicles in
                self.currentLabelText = "Loading Characters"
                ResourcePage.fetchArray(resourceClass: Character.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { characters in
                    for vehicle in vehicles {
                        var veh = vehicle
                        var pilotNames: [String] = []
                        if let pilots = vehicle.pilots {
                            for pilot in pilots {
                                if let pilotName = characters.findNameByUrl(url: pilot) {
                                    pilotNames.append(pilotName.capitalized)
                                } else {
                                    pilotNames.append("Unknown character (\(pilot))")
                                }
                            }
                            veh.pilots = pilotNames
                        }
                        self.resourceArray.append(veh)
                    }
                    self.showAll()
                    self.currentItem = 0
                    self.pickerView.reloadAllComponents()
                    self.activity.stopAnimating()
                    self.quickFactsBar.resource = self.resourceArray
                    self.quickFactsBar.nextFact(sender: nil)
                }
            }
        case .Starship:
            hideAll()
            self.currentLabelText = "Loading Starships"
            ResourcePage.fetchArray(resourceClass: Starship.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { starships in
                self.currentLabelText = "Loading Characters"
                ResourcePage.fetchArray(resourceClass: Character.self, progressTo: self.progressTo(value: ), labelText: self.labelText(text: )) { characters in
                    for starship in starships {
                        var ship = starship
                        var pilotNames: [String] = []
                        if let pilots = starship.pilots {
                            for pilot in pilots {
                                if let pilotName = characters.findNameByUrl(url: pilot) {
                                    pilotNames.append(pilotName.capitalized)
                                } else {
                                    pilotNames.append("Unknown character (\(pilot))")
                                }
                            }
                            ship.pilots = pilotNames
                        }
                        self.resourceArray.append(ship)
                
                    }
                    self.showAll()
                    self.currentItem = 0
                    self.pickerView.reloadAllComponents()
                    self.activity.stopAnimating()
                    self.quickFactsBar.resource = self.resourceArray
                    self.quickFactsBar.nextFact(sender: nil)
                }
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        if (!resourceArray.isEmpty) {
            label.text = self.resourceArray[row].name
        }
        return label
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
    func hideAll() {
        self.tableView.isHidden = true
        self.pickerView.isHidden = true
        self.usdButton.isHidden = true
        self.creditsButton.isHidden = true
        self.metricsButton.isHidden = true
        self.englishButton.isHidden = true
        self.statusLabel.isHidden = false
        self.activity.isHidden = false
        self.progress.isHidden = false
    }
    
    func showAll() {
        self.tableView.isHidden = false
        self.pickerView.isHidden = false
        if (self.unitType != .Character) {
            self.usdButton.isHidden = false
            self.creditsButton.isHidden = false
        }
        self.metricsButton.isHidden = false
        self.englishButton.isHidden = false
        self.statusLabel.isHidden = true
        self.activity.isHidden = true
        self.progress.isHidden = true
    }
}
