//
//  HypedEventListView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-16.
//

import SwiftUI

struct HypedEventListView: View {
    
    var hypedEvents: [HypedEvent]
    var noEventsText: String
    var isDiscover = false
    
    var body: some View {
        ScrollView {
            VStack {
                if hypedEvents.count == 0 {
                    Text(noEventsText)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                } else {
                    ForEach(hypedEvents) { hypedEvent in
                        NavigationLink(
                            destination:
                                HypedEventDetailView(
                                    hypedEvent: hypedEvent,
                                    isDiscover: isDiscover)) {
                                    HypedEventTileView(hypedEvent:
                                                        hypedEvent)
                                }
                                .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    struct HypedEventListView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                HypedEventListView(hypedEvents: [testHypedEvent1, testHypedEvent2], noEventsText: "Nothing here :(")
                
                HypedEventListView(hypedEvents: [], noEventsText: "Nothing here :(")
            }
            
        }
    }
}
