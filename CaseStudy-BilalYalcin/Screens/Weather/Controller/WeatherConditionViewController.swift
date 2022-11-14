//
//  WeatherConditionViewController.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherConditionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NetworkActivityIndicatorPresentable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var conditionImg: UIImageView!
    
    var apiKeyfromHomeVC = ""
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    private var cityName: String!
    private var currentTemp: Int!
    private var weatherImg: String!
    
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        registerTableViewCell()
        manageLocation()
    }
    
    func setData(){
        debugPrint("API Value : ",apiKeyfromHomeVC)
        APIKEY = apiKeyfromHomeVC
    }
    
    func registerTableViewCell(){
        tableView.register(WeatherConditionTableViewCell.self, forCellReuseIdentifier: Cell_IDENTIFIER)
        
        let weatherConditionTableViewCell = UINib(nibName: Cell_IDENTIFIER,
                                                  bundle: nil)
        tableView.register(weatherConditionTableViewCell,
                           forCellReuseIdentifier: Cell_IDENTIFIER)
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    func manageLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func updateMainUI() {
        locationLbl.text = cityName
        dateLbl.text = "\(currentTemp!)" + DEGREE_ICON
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(weatherImg!)@2x.png")
        conditionImg.kf.setImage(with: url)
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            // Call Service
            self.downloadWeatherData {}
            self.downloadForecastData{}
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell  = tableView.dequeueReusableCell(withIdentifier: Cell_IDENTIFIER, for: indexPath) as? WeatherConditionTableViewCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherConditionTableViewCell()
        }
    }
    
    
    func downloadWeatherData(completed: @escaping DownloadComplete) {
        showNetworkActivityIndicator()
        let request = AF.request(CURRENT_WEATHER_URL)
        request.responseJSON { (response) in
            if let dict = response.value as? [String: AnyObject] {
                if let name = dict["name"] as? String {
                    self.cityName = name.capitalized
                    
                    if let main = dict["main"] as? Dictionary<String,Any> {
                        if let currentTemperature = main["temp"] as? Double {
                            
                            let kelvinToCelsius = round(300 - currentTemperature)
                            self.currentTemp = Int(kelvinToCelsius)
                        }
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String,Any>] {
                        if let main = weather[0]["icon"] as? String {
                            self.weatherImg = main
                        }
                    }
                    self.hideNetworkActivityIndicator()
                    self.updateMainUI()
                }
            }
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        showNetworkActivityIndicator()
        let request = AF.request(FORECAST_URL)
        request.responseJSON { (response) in
            let result = response.value
            if let dict = result as? Dictionary<String,Any> {
                if let list = dict["list"] as? [Dictionary<String,Any>] {
                    for object in list {
                        let forecast = Forecast(weatherDict: object)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.hideNetworkActivityIndicator()
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
}



