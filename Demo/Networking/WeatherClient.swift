//
//  WeatherClient.swift
//  Demo
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import Foundation

class WeatherClient {
  var apiClient: APIClient
  
  init(apiClient: APIClient = APIClient()) {
    self.apiClient = apiClient
  }
  
  enum WeatherClientError: Error {
    case decoderError
    case inValidCity
    case unknown(message: String)
  }
  
  func getWeather(city: String,
                  completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
    
    let headers = [
      HeaderKey.RapidAPI_Host: API.RapidAPI_Host_URL,
      HeaderKey.RapidAPI_Key: RapidAPI_Key
    ]
    
    apiClient.getData(from: API.baseURL + city, headers: headers) { data, response, error in
      
      guard let data = data,
        let response = response as? HTTPURLResponse else {
          if let error = error {
            completion(.failure(error))
          }
          return
      }
      
      switch response.statusCode {
      case 200:
        do {
          let weather = try JSONDecoder().decode(LocWeather.self, from: data)
          let weatherInfo = WeatherInfo(
            cityName: weather.name,
            briefWeather: weather.weather[0].main,
            descriptiveWeather: weather.weather[0].description,
            temp: weather.main.temp,
            pressure: weather.main.pressure,
            humidity: weather.main.humidity,
            temp_min: weather.main.temp_min,
            temp_max: weather.main.temp_max
          )
          completion(.success(weatherInfo))
        } catch {
          completion(.failure(WeatherClientError.decoderError))
        }
        
      default:
        let errorMessage = try! JSONDecoder().decode(ErrorMessage.self, from: data)
        if errorMessage.message == "city not found" {
          completion(.failure(WeatherClientError.inValidCity))
        } else {
          completion(.failure(WeatherClientError.unknown(message: errorMessage.message)))
        }
      }
    }
  }
  
}


struct ErrorMessage: Decodable {
  let cod: String?
  let message: String
}
