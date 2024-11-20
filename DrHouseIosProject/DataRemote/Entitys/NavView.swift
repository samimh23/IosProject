//
//  NavigationView.swift
//  DrHouseIosProject
//
//  Created by Mac Mini 2 on 19/11/2024.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            homeSwiftUIView()
                     .tabItem {
                         Image(systemName: "house")
                         Text("Home")
                     }
                 
                 SearchView()
                     .tabItem {
                         Image(systemName: "star")
                         Text("Ai")
                     }
                 
                 ProfileView()
                     .tabItem {
                         Image(systemName: "person.crop.circle.fill")
                         Text("Profile")
                     }
             }
         }
     }

     struct HomeView: View {
         var body: some View {
             NavigationView {
                 Text("Home Screen")
                     .navigationTitle("Home")
             }
         }
     }

     struct SearchView: View {
         var body: some View {
             NavigationView {
                 Text("Search Screen")
                     .navigationTitle("Search")
             }
         }
     }

     struct ProfileView: View {
         var body: some View {
             NavigationView {
                 Text("Profile Screen")
                     .navigationTitle("Profile")
             }
         }
     }


struct  SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
