//
//  UpcomingView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-10.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        Text("Upcoming!")
            .navigationTitle("Upcoming")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: {}) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.title)
                    }
                    
                }
                
            }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
