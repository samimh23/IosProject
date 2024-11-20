//
//  homeSwiftUIView.swift
//  DrHouseIosProject
//
//  Created by Mac Mini 2 on 19/11/2024.
//

import SwiftUI

struct homeSwiftUIView: View {
    var body: some View {
        VStack {
            // Header Section
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green) // Kept the green color
                    .frame(height: 160)
                    .ignoresSafeArea(edges: .top)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Eric gonzales!")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.leading, 20)

                    Spacer()

                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                        .padding(.trailing, 20)
                }
            }

            // Track Your Meds Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Track your meds!")
                    .font(.headline)
                    .foregroundColor(.black)
                Button(action: {
                    // See Details Action
                }) {
                    Text("See Details")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .frame(height: 120)
            .padding()
            .background(
                Image("123")
                    .resizable()
                    .scaledToFill()
            )
            .cornerRadius(12)
            .padding(.horizontal)

            // Order Status Notification
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your order is on the way!")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Have you taken your medicine yet?")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Button(action: {
                        // Track order status action
                    }) {
                        Text("Track order status")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .underline()
                    }
                }
                Spacer()
            }
            .frame(height: 120)
            .padding()
            .background(
                Image("sport")
                    .resizable()
                    .scaledToFill()
            )
            .cornerRadius(12)
            .padding(.horizontal)

            // New Products Section
            VStack {
                HStack {
                    Text("New Products")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // See all action
                    }) {
                        Text("See all")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ProductCar(imageName: "vitE", title: "Vitamin E", price: "20.000DT")
                        ProductCar(imageName: "VITA", title: "Vitamin A", price: "20.000DT")
                        ProductCar(imageName: "vitb", title: "Vitamin B12", price: "20.000DT")
                        ProductCar(imageName: "vitdd", title: "Vitamin D", price: "9.900DT")
                        ProductCar(imageName: "vD", title: "Vitamin Multi D", price: "12.000DT")
                        ProductCar(imageName: "multivit", title: "Multi Vit", price: "18.000DT")
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)

            Spacer()
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

// Product Card Component
struct ProductCar: View {
    var imageName: String
    var title: String
    var price: String

    var body: some View {
        VStack(spacing: 8) {
            // Product Image
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)

            // Product Title
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 40)

            // Product Price
            Text(price)
                .font(.footnote)
                .foregroundColor(.green)
                .fontWeight(.bold)
        }
        .padding()
        .frame(width: 150, height: 200)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

struct homeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        homeSwiftUIView()
    }
}
