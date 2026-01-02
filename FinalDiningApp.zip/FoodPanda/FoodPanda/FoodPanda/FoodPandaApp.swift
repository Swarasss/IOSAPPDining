//
//  FoodPandaApp.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//
//Calls the FoodStore() brcause it contains the most important helper method.
//Main App.
import SwiftUI

@main
struct FoodDeliveryApp: App {
    @StateObject private var store = FoodStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

