//
//  WeatherApi.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//This is a little Json used
//To integrate the Weather API for users.
//In the 1st view i.e Restaurants View.
import Foundation

struct Weather: Codable {
    struct Current: Codable {
        let temperature: Double
        let windspeed: Double
    }
    let current_weather: Current
}

final class WeatherAPI {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather.Current {
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true")!
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(Weather.self, from: data).current_weather
    }
}
