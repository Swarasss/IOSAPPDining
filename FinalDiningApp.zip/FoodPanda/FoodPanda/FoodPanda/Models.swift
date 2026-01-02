//
//  Models.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//
import SwiftUI
import Foundation
//to handle cases for prepared to delivered for useers.
enum OrderStatus: String, Codable, CaseIterable {
    case received = "Received"
    case preparing = "Preparing"
    case outForDelivery = "Out for Delivery"
    case delivered = "Delivered"
}
//utilized in Restaurantsview
struct Restaurant: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var subtitle: String
    var heroImageSystemName: String
    var menu: [MenuItem]
}
//utilized in menuview
struct MenuItem: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var priceCents: Int
    var imageSystemName: String
    var isVegetarian: Bool
    var allergens: [String]
}
//utilized in CartView
struct CartItem: Identifiable, Codable, Hashable {
    let id: UUID
    var item: MenuItem
    var quantity: Int
    var note: String
    var lineTotalCents: Int {item.priceCents * quantity}
}
//address variables
struct DeliveryAddress: Codable, Hashable {
    var fullName: String
    var street: String
    var city: String
    var zip: String
    var state: String
    var apartment: String
}



//utilized in orderStatus view.
struct Order: Identifiable, Codable, Hashable {
    let id: UUID
    var restaurant: Restaurant
    var items: [CartItem]
    var address: DeliveryAddress
    var subtotalCents: Int
    var taxCents: Int
    var deliveryFeeCents: Int
    var totalCents: Int
    var status: OrderStatus
    var eta: Date
}
