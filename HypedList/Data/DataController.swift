//
//  DataController.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-16.
//

import Foundation

class DataController: ObservableObject {
    static var shared = DataController()
    
    @Published var hypedEvents: [HypedEvent] = []
    
    var upcomingHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date > Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date }
    }
    
    var pastHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date }
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
}
