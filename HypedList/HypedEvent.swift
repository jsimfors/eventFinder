//
//  HypedEvent.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-15.
//

import Foundation
import SwiftUI

class HypedEvent: ObservableObject {
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    var imageData: Data?
}


