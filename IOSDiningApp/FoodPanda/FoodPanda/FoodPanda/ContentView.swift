//
//  ContentView.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//This is the contents view.
//I want the hierarcgy to be Restaurants view -> menu view -> cart view -> checkout view.
//Works on both iphone and ipad, horizontal and vertical views as well.
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: FoodStore

    var body: some View {
        NavigationStack(path: $store.navigationPath) {
            RestaurantsView()
        }
    }
}

