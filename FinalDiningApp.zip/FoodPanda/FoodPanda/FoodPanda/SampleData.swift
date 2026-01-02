//
//  SampleData.swift
//  FoodPanda
//
//  Created by CS3714 on 12/12/25.
//
import Foundation
//Dispalys 11 food items
//Like sample data
//Finally utilized in Menu View.
enum SampleData {
    static let restaurants: [Restaurant] = [
        Restaurant(
            id: UUID(),
            name: "Campus Eats",
            subtitle: "Italian Pizza and Parisian Patisserie",
            heroImageSystemName: "fork.knife.circle",
            menu: [
                MenuItem(id: UUID(), name: "Margherita Pizza", description: "Classic neapolitan style pizza", priceCents: 2000, imageSystemName: "pizza", isVegetarian: false, allergens: ["Soy"]),
                MenuItem(id: UUID(), name: "Quattro Formaggi Pizza", description: "Topped with 4 types of cheese.", priceCents: 1055, imageSystemName: "pizza", isVegetarian: true, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Cappricciosa Pizza", description: "Tomato sauce with Salami and pepperoni", priceCents: 1195, imageSystemName: "pizza", isVegetarian: false, allergens: ["Sesame"]),
                MenuItem(id: UUID(), name: "Prosciutto e Funghi Pizza", description: "Contains Prosciutto and Mushrooms", priceCents: 1211, imageSystemName: "pizza", isVegetarian: false, allergens: ["Soy"]),
                MenuItem(id: UUID(), name: "Romana Pizza", description: "A thin crust pizza with choice of protein.", priceCents: 1600, imageSystemName: "pizza", isVegetarian: false, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Pugliese Pizza", description: "A flavorful pizza topped with tomato sauce and mazazarella", priceCents: 1799, imageSystemName: "pizza", isVegetarian: true, allergens: ["Soy"]),
                MenuItem(id: UUID(), name: "Tiramisu", description: "Parisian Tiramisu", priceCents: 1000, imageSystemName: "cake", isVegetarian: false, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Au Pon Chocolat", description: "Croissant", priceCents: 1199, imageSystemName: "croissant", isVegetarian: false, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Macaron", description: "Available in 5 signature flavors", priceCents: 1000, imageSystemName: "cookie", isVegetarian: false, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Marveilleux", description: "A meringue dome with chocolate coating", priceCents: 1234, imageSystemName: "cake", isVegetarian: true, allergens: ["Dairy"]),
                MenuItem(id: UUID(), name: "Hazelnut Chocolate pastry", description: "Chocolate pastry with a nutty hazlnut filling", priceCents: 1234, imageSystemName: "takeoutbag.and.cup.and.straw", isVegetarian: true, allergens: ["Diry"]),
                
            ]
            )
    ]
}
