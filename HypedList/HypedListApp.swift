//
//  HypedListApp.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-10.
//

import SwiftUI

@main
struct HypedListApp: App {
    var body: some Scene {
        WindowGroup {
            HypedListTabView()
                .onAppear() {
                    DataController.shared.loadData()
                    DataController.shared.getDiscoverEvents()
                    PhoneToWatchDataController.shared.setupSession()
                }
        }
    }
}
