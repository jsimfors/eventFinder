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
    
    
    func saveData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.hypedEvents) {
                UserDefaults.standard.setValue(encoded, forKey: "hypedEvents")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func loadData() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: "hypedEvents") {
                let decoder = JSONDecoder()
                if let jsonHypedEvents = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = jsonHypedEvents
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
        var request = URLRequest(url: url!)
        // request.addValue(key, forHTTPHeaderField: "secret-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let webData = try JSONDecoder().decode(RepositoryEvents.self, from: data!)

                    var hypedEventsToAdd: [HypedEvent] = []
                    for jsonEvent in webData.record {
                        print(jsonEvent.id)
                        let hypedEvent = HypedEvent()
                        
                        if let id = jsonEvent.id {
                            hypedEvent.id = id
                        }
                        
                        if let dateString = jsonEvent.date {
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
