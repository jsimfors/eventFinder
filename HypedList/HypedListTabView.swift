//
//  HypedListTabView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-10.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            NavigationView{
                UpcomingView()
            }
            .tabItem{
                Image(systemName: "calendar")
                Text("Upcoming")
                
            }
            Text("2")
                .tabItem {
                    Image(systemName: "lasso.sparkles")
                    Text("Discover")
                }
            Text("3")
                .tabItem {
                    Image(systemName: "highlighter")
                    
                    Text("Past")
                }
        }
    }
}

struct HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
            .previewDevice("iPhone 14 Pro")
    }
}
