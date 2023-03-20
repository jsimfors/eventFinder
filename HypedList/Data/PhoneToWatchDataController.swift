//
//  PhoneToWatchDataController.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-03-20.
//

import Foundation
import WatchConnectivity

class PhoneToWatchDataController:  NSObject, WCSessionDelegate {
    
    static var shared = PhoneToWatchDataController()
    var session: WCSession?
    
    func setupSession() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Activated! :)")
        default:
            print("Not able to talk to watch :(")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Now Inactive :(")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Did deactivate :(")
    }
    
    func sendContext(context: [String:Any]) {
        // Sends context from phone to watch
        print("Trying to send context from phone to watch")
        try? session?.updateApplicationContext(context)
    }
    
    func convertHypedEventsToContext(hypedEvents: [HypedEvent]) -> [String:Any] {
        var imagelessHypedEvents:  [HypedEvent] = []
        for hypedEvent in hypedEvents {
            print("Adding hyped event to list:")
            print(hypedEvent.title)
            let imagelessHypedEvent = HypedEvent()
            imagelessHypedEvent.id = hypedEvent.id
            imagelessHypedEvent.date = hypedEvent.date
            imagelessHypedEvent.title = hypedEvent.title
            imagelessHypedEvent.color = hypedEvent.color
            imagelessHypedEvent.url = hypedEvent.url
            imagelessHypedEvents.append(imagelessHypedEvent)
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(imagelessHypedEvents) {
            print("Succes with adding to imagelessEvents!")
            return ["hypedEvents":encoded]
        }
        print("Failed with adding to imagelessEvents!")
        return ["failed":0]
    }
}
