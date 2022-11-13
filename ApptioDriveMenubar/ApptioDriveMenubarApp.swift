//
//  ApptioDriveMenubarApp.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 06/11/22.
//

import SwiftUI

@main
struct ApptioDriveMenubarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView().frame(width: 0, height: 0)
        }
    }
}
