//
//  randomFact.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//This is a little Json used
//To integrate the Random facts API for users.
import Foundation

struct RandomFact: Codable {
    let text: String
}

final class RandomFactAPI {
    func fetchFact() async throws -> RandomFact {
        let url = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en")!
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(RandomFact.self, from: data)
    }
}
