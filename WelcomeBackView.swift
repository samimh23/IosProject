import SwiftUI

struct WelcomeBackView: View {
    var username: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.green)
                .frame(height: 160)
                .ignoresSafeArea(edges: .top)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("\(username)!")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.leading, 20)

                Spacer()

                Image("logo") // Replace with your actual logo name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.trailing, 20)
            }
        }
    }
}
