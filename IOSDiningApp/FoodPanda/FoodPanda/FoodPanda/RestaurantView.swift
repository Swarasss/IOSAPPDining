//
//  RestaurantView.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//The first view
//It displays the Name of the restaurant.
//Specifies Cuisine
//Displays weather utilizing API
//Displays Random funny facts for entertainment.
import SwiftUI


struct RestaurantsView: View {
    @EnvironmentObject var store: FoodStore

    // API State variables
    @State private var weather: Weather.Current?
    @State private var fact: String = ""
   
    var body: some View {
        List {
            //API Info Section
            if weather != nil || !fact.isEmpty {
                Section(header: Text("Today's Info")) {
                    if let weather = weather {
                        Text("Current Temp: \(weather.temperature, specifier: "%.1f")°C, Wind: \(weather.windspeed, specifier: "%.1f") km/h")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    if !fact.isEmpty {
                        Text("Random Fact: \(fact)")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
           
            //Restaurants List
            ForEach(store.restaurants) { restaurant in
                NavigationLink(value: restaurant) {
                    Label {
                        VStack(alignment: .leading) {
                            Text(restaurant.name)
                                .font(.headline)
                            Text(restaurant.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    } icon: {
                        Image(systemName: restaurant.heroImageSystemName)
                    }
                }
            }
        }
        .navigationTitle("Restaurants")
        .navigationDestination(for: Restaurant.self) { restaurant in
            MenuView(restaurant: restaurant)
                .onAppear {
                    store.selectedRestaurant = restaurant
                }
        }
        .task {
            await fetchWeather()
            await fetchFact()
        }
    }
   
    // Fetches Weather via API
    private func fetchWeather() async {
        do {
            weather = try await WeatherAPI().fetchCurrentWeather(lat: 37.2296, lon: -80.4139)
        } catch {
            print("Weather fetch failed: \(error)")
        }
    }
   
    //Fetches Random Facts via API
    private func fetchFact() async {
        do {
            let randomFact = try await RandomFactAPI().fetchFact()
            fact = randomFact.text
        } catch {
            print("Fact fetch failed: \(error)")
        }
    }
}

//Preview
#Preview {
    NavigationStack {
        RestaurantsView()
            .environmentObject(FoodStore())
    }
}
