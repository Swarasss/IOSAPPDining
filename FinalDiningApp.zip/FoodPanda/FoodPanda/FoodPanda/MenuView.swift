import SwiftUI
//This is the menu view, The second view
//It displays a list of all the items in the menu and lets people add to cart.
struct MenuView: View {
    @EnvironmentObject var store: FoodStore
    let restaurant: Restaurant
    //Also deals with the UI
    var body: some View {
        List {
            Section(header: Text("Menu")) {
                ForEach(restaurant.menu) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.imageSystemName).font(.title2)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name).font(.headline)
                            Text(item.description).font(.caption).foregroundColor(.secondary)
                            Text(Money.cents(item.priceCents)).font(.subheadline)
                        }
                        Spacer()
                        
                        
                        Button {
                            store.addToCart(item)
                        } label: {
                            HStack(spacing: 4) {
                                Text("Add")
                                // Show quantity if > 0
                                if let cartItem = store.cart.first(where: { $0.item.id == item.id }) {
                                    Text("(\(cartItem.quantity))")
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.vertical, 4)
                    }
                }
            }
            //Navigates to the cart view
            //utilizes Route.swift.
            Section {
                NavigationLink(value: Route.cart) {
                    HStack {
                        Text("View Cart")
                        Spacer()
                        if store.totalCents > 0 {
                            Text(Money.cents(store.totalCents))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(restaurant.name)
        
        // Typed navigation destinations
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .cart:
                CartView()
                
            case .orderStatus:
                OrderStatusView()
            }
        }
    }
}

enum Money {
    static func cents(_ c: Int) -> String {
        let dollars = Double(c) / 100.0
        return dollars.formatted(.currency(code: "USD"))
    }
}
