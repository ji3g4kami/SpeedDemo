//
//  Weather.swift
//  Demo
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

struct LocWeather: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Decodable {
    let temp: Float
    let pressure: Int
    let humidity: Int
    let temp_min: Float
    let temp_max: Float
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct WeatherInfo {
    let cityName: String
    let briefWeather: String
    let descriptiveWeather: String
    let temp: Float
    let pressure: Int
    let humidity: Int
    let temp_min: Float
    let temp_max: Float
}
