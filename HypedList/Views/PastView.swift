//
//  PastView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-16.
//

import SwiftUI

struct PastView: View {
    @ObservedObject var data = DataController.shared

    var body: some View {
        HypedEventListView(hypedEvents: data.pastHypedEvents, noEventsText: "Here past event will show in the future")
            .navigationTitle("Past")
    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
