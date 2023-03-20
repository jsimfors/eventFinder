//
//  WatchToPhoneDataController.swift
//  HypedListWatch Watch App
//
//  Created by Johanna Simfors on 2023-03-20.
//
import Foundation
import WatchConnectivity

class WatchToPhoneDataController:  NSObject, WCSessionDelegate, ObservableObject {
    
    static var shared = WatchToPhoneDataController()
    @Published var hypedEvents: [HypedEvent] = []
    
    var session = WCSession.default
    
    override init() {
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Activated! :)")
        default:
            print("Not able to talk to watch :(")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        // To read the information
        decodeContext(context: applicationContext)
        
    }
    
    func decodeContext(context: [String:Any]) {
        if let hypedData = context["hypedEvents"] as? Data {
            let decoder = JSONDecoder()
            if let hypedEventsJSON = try? decoder.decode([HypedEvent].self, from: hypedData) {
                DispatchQueue.main.async {
                    print("updates hypedEvents! :)")
                    self.hypedEvents = hypedEventsJSON
                }
                
                
            }
        }
        
    }
    
}
