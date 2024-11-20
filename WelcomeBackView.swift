import SwiftUI

struct WelcomeBackView: View {
    var username: String
    var avatarImage: String // This will hold the dynamic avatar image name
    
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

                Image(avatarImage) // Use the dynamic avatar image here
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

struct ContentView: View {
    var body: some View {
        WelcomeBackView(username: "Eric Gonzales", avatarImage: "profile_picture") // Dynamically pass image name
    }
}
