//
//  DataController.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-16.
//

import Foundation
import SwiftDate
import UIColorHexSwift
import SwiftUI

class DataController: ObservableObject {
    static var shared = DataController()
    
    @Published var hypedEvents: [HypedEvent] = []
    @Published var discoverHypedEvents: [HypedEvent] = []
    
    var upcomingHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date > Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date }
    }
    
    var pastHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date }
    }
    
    func addFromDiscover(hypedEvent: HypedEvent) {
        hypedEvents.append(hypedEvent)
        hypedEvent.objectWillChange.send()
        saveData()
    }
    
    func deleteHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: {loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
            hypedEvents.remove(at: index)
        }
        saveData()
    }
    
    func saveHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: {loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
            hypedEvents[index] = hypedEvent
        } else {
            hypedEvents.append(hypedEvent)
        }
        saveData()
    }
    
    
    func saveData() {
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.com.johannatest.HypedList") {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(self.hypedEvents) {
                    defaults.setValue(encoded, forKey: "hypedEvents")
                    defaults.synchronize()
                    
                }
                PhoneToWatchDataController.shared.sendContext(context: PhoneToWatchDataController.shared.convertHypedEventsToContext(hypedEvents: self.upcomingHypedEvents))
                
            }
        }
    }
    
    func loadData() {
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.com.johannatest.HypedList") {
                if let data = defaults.data(forKey: "hypedEvents") {
                    let decoder = JSONDecoder()
                    if let jsonHypedEvents = try? decoder.decode([HypedEvent].self, from: data) {
                        DispatchQueue.main.async {
                            self.hypedEvents = jsonHypedEvents
                            PhoneToWatchDataController.shared.sendContext(context: PhoneToWatchDataController.shared.convertHypedEventsToContext(hypedEvents: self.upcomingHypedEvents))
                        }
                    }
                }
            }
        }
    }
    
    struct RepositoryEvents: Decodable {
        let record: [EventItem]
        
    }
    
    struct EventItem: Decodable {
        let id: String?
        let date: String?
        let title: String?
        let url: String?
        let color: String?
        let imageData: String?
        
    }
    
    func getDiscoverEvents() {
        print("0")
        
        let url = URL (string: "https://api.jsonbin.io/v3/b/63f4be99ebd26539d0827ed1/latest")
        // let key = "$2b$10$9C.deJvzx/MpqDkQvQZFVuyubEM..ugzLGWPZVrFI9TfBHcQXvBv2"
        let request = URLRequest(url: url!)
        // request.addValue(key, forHTTPHeaderField: "secret-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let webData = try JSONDecoder().decode(RepositoryEvents.self, from: data!)
                    
                    var hypedEventsToAdd: [HypedEvent] = []
                    for jsonEvent in webData.record {
                        let hypedEvent = HypedEvent()
                        
                        if let id = jsonEvent.id {
                            hypedEvent.id = id
                        }
                        
                        if let dateString = jsonEvent.date {
                            SwiftDate.defaultRegion = Region.local
                            if let dateInRegion = dateString.toDate() {
                                hypedEvent.date = dateInRegion.date
                            }
                        }
                        
                        if let title = jsonEvent.title {
                            hypedEvent.title = title
                        }
                        
                        if let url = jsonEvent.url {
                            hypedEvent.url = url
                        }
                        
                        if let colorHex = jsonEvent.color {
                            hypedEvent.color = Color(UIColor("#" + colorHex))
                        }
                        
                        if let imageURL = jsonEvent.imageData {
                            if let url = URL(string: imageURL) {
                                if let data = try? Data(contentsOf: url) {
                                    hypedEvent.imageData = data
                                }
                            }
                        }
                        hypedEventsToAdd.append(hypedEvent)
                    }
                    DispatchQueue.main.async {
                        self.discoverHypedEvents = hypedEventsToAdd
                    }
                }catch {
                    print (error)
                }
                
            }
        }.resume()
    }
}
