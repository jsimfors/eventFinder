//
//  HypedEventWatchListView.swift
//  HypedListWatch Watch App
//
//  Created by Johanna Simfors on 2023-03-16.
//

import SwiftUI

struct HypedEventWatchListView: View {
    
    var hypedEvents: [HypedEvent]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HypedEventWatchListView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventWatchListView(hypedEvents: [testHypedEvent1, testHypedEvent2])
    }
}
