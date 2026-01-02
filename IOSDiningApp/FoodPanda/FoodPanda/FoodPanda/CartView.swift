import SwiftUI
//This view is the one of the 4 main views
//It deals with the cart math like adding the total items, tax, and delivery fee
struct CartView: View {
    @EnvironmentObject var store: FoodStore
    @State private var address =
    DeliveryAddress(fullName: "", street: "", city: "", zip: "", state: "", apartment: "")
    @State private var errorMessage: String?
    @State private var translating = false
    
//If nothing is added to the cart then it shows the cart is empty view.
    var body: some View {
        List {
            if store.cartIsEmpty {
                ContentUnavailableView("Your cart is empty",
                                       systemImage: "cart",
                                       description: Text("Add items from the menu to get started."))
            } else {
                Section(header: Text("Items")) {
                    ForEach(store.cart) { ci in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(ci.item.name).font(.headline)
                                Spacer()
                                Text(Money.cents(ci.lineTotalCents))
                            }
                            //Deals with adding the # of items.

                            Stepper("Qty: \(ci.quantity)") {
                                store.setQuantity(for: ci.id, quantity: ci.quantity + 1)
                            } onDecrement: {
                                store.setQuantity(for: ci.id, quantity: ci.quantity - 1)
                            }

                            TextField("Add a note (allergy/modification)", text: Binding(
                                get: { ci.note },
                                set: { store.updateNote(for: ci.id, note: $0) }
                            ))
                            .textFieldStyle(.roundedBorder)

                            
                        }
                        .swipeActions {
                            Button(role: .destructive) { store.removeFromCart(ci) } label: { Text("Remove") }
                        }
                    }
                }

                Section(header: Text("Totals")) {
                    row("Subtotal", Money.cents(store.subtotalCents))
                    row("Tax", Money.cents(store.taxCents))
                    row("Delivery fee", Money.cents(store.deliveryFeeCents))
                    row("Total", Money.cents(store.totalCents), bold: true)
                }
                //This is where the user enter their address.

                Section(header: Text("Delivery Address")) {
                    TextField("Full name", text: $address.fullName)
                    TextField("Street", text: $address.street)
                    TextField("City", text: $address.city)
                    TextField("State", text: $address.state)
                    TextField("ZIP", text: $address.zip)
                        .keyboardType(.numberPad)
                    TextField("Apartment name", text: $address.apartment)
                    
                }
                //Navigates to the checkout or order status view.

                Section {
                        Button("Place Order") {
                            do {
                                try store.placeOrder(address: address)
                                store.navigationPath.append(Route.orderStatus)
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                   
                }
            }
        }
        .navigationTitle("Cart")
        .alert("Checkout issue", isPresented: Binding(
            get: { errorMessage != nil },
            set: { _ in errorMessage = nil }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage ?? "")
        }
    }

    private func row(_ left: String, _ right: String, bold: Bool = false) -> some View {
        HStack {
            Text(left)
            Spacer()
            Text(right).fontWeight(bold ? .semibold : .regular)
        }
    }
}

private extension FoodStore {
    var cartIsEmpty: Bool { cart.isEmpty }
}


