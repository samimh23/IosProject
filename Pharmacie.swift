import SwiftUI

import SwiftUI

struct PharmacyShopView: View {
    @State private var products = [
        Product(name: "Xanax", price: 2.5, image: "xanax", category: "Vitamins"),
        Product(name: "Panadol Extra", price: 3.0, image: "pandol", category: "GSL"),
        Product(name: "Cough Syrup", price: 4.5, image: "cough_syrup", category: "GSL"),
        Product(name: "Vitamin C", price: 5.0, image: "vitamin_c", category: "Prescription Only"),
        Product(name: "Zinc Tablets", price: 6.0, image: "zinc_tablets", category: "Prescription Only")
    ]
    
    @State private var selectedCategory = "All"
    @State private var cart: [Product] = []
    
    let categories = ["All", "Vitamins", "GSL", "Prescription Only", "Pharmacy Medicine"]
    
    var filteredProducts: [Product] {
        if selectedCategory == "All" {
            return products
        } else {
            return products.filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {  // Adjust spacing here to control the space between sections
                // Welcome Back Section with Avatar
                WelcomeBackView(username: "Eric Gonzales", avatarImage: "123") // Replace with dynamic username
                
                // Hero Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Have a Prescription?")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Upload it and get your medicine in one tap!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "arrow.right.circle")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.yellow.opacity(0.1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)
                }
                .padding(.horizontal)
                
                // Search Bar Section
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search products...", text: .constant(""))
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                .padding(.top, 10)  // Adjust this padding for the search area
                
                // Horizontal Category Grid
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(selectedCategory == category ? Color.green : Color.gray.opacity(0.05))
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .cornerRadius(20)
                                    .shadow(radius: selectedCategory == category ? 5 : 0)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 12)
                
                // Product Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product, onAddToCart: {
                                cart.append(product)
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Cart Navigation
                NavigationLink(destination: CartView(cart: cart)) {
                    Text("View Cart (\(cart.count))")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
                .padding(.bottom)
            }
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}



struct ProductCard: View {
    let product: Product
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
                
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(height: 150)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(String(format: "$%.2f", product.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Button(action: onAddToCart) {
                HStack {
                    Image(systemName: "cart.badge.plus")
                    Text("Add to Cart")
                        .fontWeight(.bold)
                }
                .font(.subheadline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 3)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
    }
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let image: String
    let category: String
}

struct PharmacyShopView_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyShopView()
    }
}
