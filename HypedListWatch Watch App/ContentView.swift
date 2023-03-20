//
//  ContentView.swift
//  HypedListWatch Watch App
//
//  Created by Johanna Simfors on 2023-03-15.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var data = WatchToPhoneDataController.shared
    
    var body: some View {
        HypedEventWatchListView(hypedEvents: data.hypedEvents)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
