//
//  Constants.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import Foundation

typealias DownloadComplete = () -> ()

enum excludeValues : String {
    case current  = "current"
    case minutely = "minutely"
    case hourly   = "hourly"
    case daily    = "daily"
    case alerts   = "alerts"
}

let TEST_APIKEY = "8ddadecc7ae4f56fee73b2b405a63659"
let FORECAST_APIKEY = "f5549953a5b2873dff7a203717f0b90f"
let segueIdentifier = "showDetailSegue"
var APIKEY = ""
let DEGREE_ICON = "°"
let Cell_IDENTIFIER = "WeatherConditionTableViewCell"

let CURRENT_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(APIKEY)"

let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=\(FORECAST_APIKEY)"

//MARK: Alert Strings
let warningTitle = "Uyarı"
let warningMessage = "API KEY değerini boş bırakmayınız."
let warningButtonTitle = "OK"
