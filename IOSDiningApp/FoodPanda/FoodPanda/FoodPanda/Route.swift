//
//  Route.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//
//Just a helper for navigating from MenuView to CartView.
//I want the hierarcgy to be Restaurants view -> menu view -> cart view -> checkout view.
//This is why it is necessary.
enum Route: Hashable {
    case cart
    case orderStatus
}
