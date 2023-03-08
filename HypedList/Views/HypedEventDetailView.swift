//
//  HypedEventDetailView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-03-08.
//

import SwiftUI

struct HypedEventDetailView: View {
    
    var hypedEvent: HypedEvent
    var isDiscover = false
    
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
            
            Text("\(hypedEvent.timeFromNow().capitalized) on \(hypedEvent.dateAsString())").font(.title2)
            
            Spacer()
            
            if hypedEvent.validURL() != nil {
                Button(action: {}) {
                    HypedEventDetailViewButton(backgroundColor: .orange, imageName: "link", text: "Visit site")
                }
            }
            if isDiscover {
                Button(action: {}) {
                    HypedEventDetailViewButton(backgroundColor: .blue, imageName: "plus.circle", text: "Add")
                }
            } else {
                
                Button(action: {}) {
                    HypedEventDetailViewButton(backgroundColor: .green, imageName: "pencil.circle", text: "Edit")
                }
                Button(action: {}) {
                    HypedEventDetailViewButton(backgroundColor: .red, imageName: "trash", text: "Delete event")
                }
            }
            
            
        }
        
    }
    
}

struct HypedEventDetailViewButton: View {
    
    var backgroundColor: Color
    var imageName: String
    var text: String
    
    var body: some View {
        
        HStack {
            Spacer()
            Image(systemName: imageName)
            Text(text)
            Spacer()
        }
        .font(.title2)
        .padding(12)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(5)
        .padding(.top, 10)
        .padding(.horizontal, 20)
    }
    
}

struct HypedEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypedEventDetailView(hypedEvent: testHypedEvent1)
            HypedEventDetailViewButton(backgroundColor: .orange, imageName: "link", text: "Visit Site")
        }
    }
}
