//
//  HypedEventTileView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-15.
//

import SwiftUI

struct HypedEventTileView: View {
    var hypedEvent: HypedEvent
    var body: some View {
        VStack(spacing: 0) {
            Text(hypedEvent.title)
                .padding()
                .font(.largeTitle)
            
            Rectangle()
                .foregroundColor(hypedEvent.color)
                .frame(height: 15)
               
            
            if hypedEvent.image() != nil {
                hypedEvent.image()!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding()
                    
            }
            
            Rectangle()
                .foregroundColor(hypedEvent.color)
                .frame(height: 15)
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.red)
                Text(hypedEvent.dateAsString())
                Spacer()
                Text(hypedEvent.timeFromNow())
                     Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                
            }
            .padding(.bottom, 10)
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .font(.title3)
            .background(Color.white)
            
        }   .background(hypedEvent.color)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(20)
        
    }
}

struct HypedEventTileView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventTileView(hypedEvent: testHypedEvent1)
    }
}
