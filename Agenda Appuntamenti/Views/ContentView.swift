//
//  ContentView.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import SwiftUI
import FirebaseFirestoreSwift



struct ContentView: View {
    @State private var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            Incompleti()
                .tabItem {
                    Label("Incompleti", systemImage: "scissors")
                }
                .tag("Home")
            Completi()
                .tabItem {
                    Label("Completi", systemImage: "person.fill.checkmark")
                }
                .tag("Incompleti")
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
