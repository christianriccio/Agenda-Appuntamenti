//
//  Agenda_AppuntamentiApp.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import FirebaseFirestore
import SwiftUI
import Firebase
import FirebaseCore

@main
struct Agenda_AppuntamentiApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
