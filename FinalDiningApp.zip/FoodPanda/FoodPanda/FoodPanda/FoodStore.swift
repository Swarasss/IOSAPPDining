import Foundation
import SwiftUI
import Combine
//This file has a lot of helper functions used in various views.
@MainActor
final class FoodStore: ObservableObject {

    //  Data
    @Published var restaurants: [Restaurant] = SampleData.restaurants
    @Published var selectedRestaurant: Restaurant? = nil

    // Cart
    @Published private(set) var cart: [CartItem] = []

    // Checkout/Order
    @Published var currentOrder: Order? = nil
    
    @Published var navigationPath = NavigationPath()

    // Pricing (unit tested these)
    //hardcoded tax and delivery fee
    let taxRate: Double = 0.06
    let deliveryFeeCents: Int = 299

    //This deals with the quantity of items logic.
    func addToCart(_ item: MenuItem) {
        if let idx = cart.firstIndex(where: { $0.item.id == item.id }) {
            cart[idx].quantity += 1
        } else {
            cart.append(CartItem(id: UUID(), item: item, quantity: 1, note: ""))
        }
    }
    //This handles when the customer wants to delete the item from the cart.
    func removeFromCart(_ cartItem: CartItem) {
        cart.removeAll { $0.id == cartItem.id }
    }

    func updateNote(for cartItemID: UUID, note: String) {
        guard let idx = cart.firstIndex(where: { $0.id == cartItemID }) else { return }
        cart[idx].note = note
    }

    //This deals with the quantity login in Cart view.
    func setQuantity(for cartItemID: UUID, quantity: Int) {
        guard let idx = cart.firstIndex(where: { $0.id == cartItemID }) else { return }

        if quantity <= 0 {
            cart.remove(at: idx)
        } else {
            cart[idx].quantity = quantity
        }
    }
    //This converts cents to dollars.
    var subtotalCents: Int { cart.reduce(0) { $0 + $1.lineTotalCents } }
    //This is how cents and dollars logic is handled
    var taxCents: Int {
        Int((Double(subtotalCents) * taxRate).rounded())
    }

    var totalCents: Int {
        guard !cart.isEmpty else { return 0 }
        return subtotalCents + taxCents + deliveryFeeCents
    }
    //Main
    //Error handling logic
    //If a user makes a mistake, that is, does not eneter full address
    //Then an error box appears 
    //which tells them to fill all components of address
    func placeOrder(address: DeliveryAddress) throws {
        guard let restaurant = selectedRestaurant else { throw CheckoutError.noRestaurantSelected }
        guard !cart.isEmpty else { throw CheckoutError.emptyCart }
        guard !address.fullName.trimmingCharacters(in: .whitespaces).isEmpty else { throw CheckoutError.invalidAddress("Name is required.") }
        guard !address.street.isEmpty, !address.city.isEmpty, !address.state.isEmpty, !address.zip.isEmpty,!address.apartment.isEmpty else {
            throw CheckoutError.invalidAddress("Please complete all address fields.")
        }
        let orderedItems = cart

        let order = Order(
            id: UUID(),
            restaurant: restaurant,
            items: orderedItems,
           // items: cart,
            address: address,
            subtotalCents: subtotalCents,
            taxCents: taxCents,
            deliveryFeeCents: deliveryFeeCents,
            totalCents: totalCents,
            status: .received,
            eta: Date().addingTimeInterval(35 * 60)
        )

        currentOrder = order
        cart.removeAll()
    }
    //This is how the received, prepared, and delivered order status is refreshed.
    func manualRefreshOrderStatus() {
        guard var order = currentOrder else { return }

        // Move to the next status
        switch order.status {
        case .received:
            order.status = .preparing
        case .preparing:
            order.status = .outForDelivery
        case .outForDelivery:
            order.status = .delivered
        case .delivered:
            break
        }

        // Increment ETA by 10 minutes for each refresh, unless delivered
        if order.status != .delivered {
            order.eta = order.eta.addingTimeInterval(10 * 60) 
        }

        currentOrder = order
    }
    
    //This also handles the checkout error.
    enum CheckoutError: LocalizedError {
        case emptyCart
        case noRestaurantSelected
        case invalidAddress(String)

        var errorDescription: String? {
            switch self {
            case .emptyCart: return "Your cart is empty."
            case .noRestaurantSelected: return "Please select a restaurant first."
            case .invalidAddress(let msg): return msg
            }
        }
    }
}



