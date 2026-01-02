//
//  WeatherManager.swift
//  Clima
//
//  Created by Damoon saber on 10/7/1404 AP.
//  Copyright © 1404 AP App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a6b34091937ee4bc4deb3950a3bfaf46&q=london&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. creat a URL
        if let url = URL(string: urlString) {
            
            //2. creat session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //4.Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodeData.weather[0].id)
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.getConditionName(weatherId: id))
            
        } catch {
            print(error)
        }
    }
  
}
