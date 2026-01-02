import SwiftUI

//The 4th view. 
//It displays the order status
//Checkout View or order status view.
//Display a status timeline 
//(Received → Preparing → Out for Delivery → Delivered) and ETA.
struct OrderStatusView: View {
    @EnvironmentObject var store: FoodStore

    var body: some View {
        List {
            if let order = store.currentOrder {

                // STATUS TIMELINE
                Section(header: Text("Order Status")) {
                    ForEach(OrderStatus.allCases, id: \.self) { step in
                        HStack {
                            Image(systemName: icon(for: step, current: order.status))
                                .foregroundColor(.blue)
                            Text(step.rawValue)
                                .fontWeight(step == order.status ? .bold : .regular)
                        }
                    }

                    HStack {
                        Text("ETA")
                        Spacer()
                        Text(order.eta.formatted(date: .omitted, time: .shortened))
                            .foregroundColor(.secondary)
                    }

                    Button("Refresh Status") {
                        store.manualRefreshOrderStatus()
                    }
                }

                // ORDERED ITEMS
                Section(header: Text("Items Ordered")) {
                    ForEach(order.items) { item in
                        HStack {
                            Text("\(item.quantity)x \(item.item.name)")
                            Spacer()
                            Text(Money.cents(item.lineTotalCents))
                        }
                    }
                }

                //  TOTAL
                Section(header: Text("Total")) {
                    HStack {
                        Text("Order Total")
                        Spacer()
                        Text(Money.cents(order.totalCents))
                            .fontWeight(.bold)
                    }
                }

            } else {
                ContentUnavailableView(
                    "No active order",
                    systemImage: "clock",
                    description: Text("Place an order to see its status.")
                )
            }
        }
        .navigationTitle("Order Status")
    }

    private func icon(for step: OrderStatus, current: OrderStatus) -> String {
        let all = OrderStatus.allCases
        return all.firstIndex(of: step)! <= all.firstIndex(of: current)!
            ? "checkmark.circle.fill"
            : "circle"
    }
}
