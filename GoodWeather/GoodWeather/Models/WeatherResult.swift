//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by Kas Song on 1/11/21.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
