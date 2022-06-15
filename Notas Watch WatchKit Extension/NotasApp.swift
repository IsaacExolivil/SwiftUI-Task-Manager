//
//  NotasApp.swift
//  Notas Watch WatchKit Extension
//
//  Created by Jose Isaac on 14/06/22.
//

import SwiftUI

@main
struct NotasApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
