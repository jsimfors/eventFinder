//
//  UpcomingView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-10.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    var hypedEvents: [HypedEvent] = []
    
    var body: some View {
        ScrollView {
            VStack {
                if hypedEvents.count == 0 {
                    Text("Nothing to look forward to 😪\nCreate an event or check out the Discover tap!")
                        .multilineTextAlignment(.center)
                } else {
                    ForEach(hypedEvents) { hypedEvent in
                        HypedEventTileView(hypedEvent: hypedEvent)
                    }
                }
            }
        }
        .navigationTitle("Upcoming")
        .toolbar {
            ToolbarItemGroup {
                Button(action: {
                    showingCreateView = true
                    
                }) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.title)
                }
                .sheet(isPresented:
                        $showingCreateView){
                    CreateHypedEventView()
                }
                
            }
            
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            NavigationView {
                UpcomingView(hypedEvents: [testHypedEvent1, testHypedEvent2])
            }
            NavigationView {
                UpcomingView(hypedEvents: [])
            }
        }
    }
}
