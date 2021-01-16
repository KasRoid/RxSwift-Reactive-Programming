//
//  URL+Extensions.swift
//  GoodWeather
//
//  Created by Kas Song on 1/12/21.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=b9719572e5d4d135129189b5d6456ad8")
    }
}
