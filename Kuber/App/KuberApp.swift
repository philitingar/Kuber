//
//  KuberApp.swift
//  Kuber
//
//  Created by Timi on 15/2/23.
//

import SwiftUI

@main
struct KuberApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)// a single instance that we can use across multiple places in the app
            
        }
    }
}
