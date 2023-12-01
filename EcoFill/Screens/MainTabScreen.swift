//
//  ContentView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

struct MainTabScreen: View {
    var body: some View {
      TabView {
        // Home Screen setup
        HomeScreen()
          .tabItem {
            Label("Головна", systemImage: "house")
          }
        // Map Screen setup
        MapScreen()
          .tabItem {
            Label("Карти", systemImage: "map")
          }
        // Profile Screen Setup
        ProfileScreen()
          .tabItem {
            Label("Профіль", systemImage: "person.fill")
          }
      }
    }
}

#Preview {
    MainTabScreen()
}
