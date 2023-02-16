//
//  HypedEvent.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-15.
//

import Foundation
import SwiftUI
import SwiftDate

class HypedEvent: ObservableObject, Identifiable {
    var id = UUID().uuidString
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    @Published var imageData: Data?
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        if date.compare(.isThisYear) {
            formatter.dateFormat = "d MMM"
        } else {
            formatter.dateFormat = "d MMM yyyy"
        }
        
        return formatter.string(from: date)
    }
    
    func timeFromNow() -> String {
        return date.toRelative(since: DateInRegion())
    }
}


var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    
    if let image = UIImage(named: "beaver") {
        if let data = image.pngData() {
            hypedEvent.imageData = data
        }
    }
    
    hypedEvent.title = "Beaver Party 2023 🦫🎉"
    hypedEvent.color = .green
    hypedEvent.date = Date() + 444.days
    hypedEvent.url = "apple.com"
    
    return hypedEvent
    
}


var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()
    
    hypedEvent.title = "Nothing"
    hypedEvent.color = .pink
    hypedEvent.date = Date() + 2.hours + 23.minutes
    
    return hypedEvent
    
}


