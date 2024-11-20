import SwiftUI

struct CartView: View {
    // Receive the cart items from the previous view
    let cart: [Product]
    
    var body: some View {
        VStack {
            if cart.isEmpty {
                // Show an empty state message
                Text("Your cart is empty")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Show the list of cart items
                List(cart) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(String(format: "$%.2f", product.price))
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle("Cart")
        .padding()
    }
}
