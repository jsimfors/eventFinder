//
//  DiscoverView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-21.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        HypedEventListView(hypedEvents: data.discoverHypedEvents.sorted { $0.date < $1.date }, noEventsText: "Loading events to discover...",
            isDiscover: true)
            .navigationTitle("Discover")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: {
                        data.getDiscoverEvents()
                        
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                    }
                    
                }
                
            }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
