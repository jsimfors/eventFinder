//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Johanna Simfors on 2023-02-15.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false
    
    var body: some View {
        Form {
            Section {
                FormLabelView(title: "Title", iconSystemName: "keyboard", color: Color.blue)
                TextField("Family Vacation", text: $hypedEvent.title)
                    .autocapitalization(.words)
            }
            Section {
                FormLabelView(title: "Date", iconSystemName: "calendar", color: Color.pink)
                
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTime) {
                    FormLabelView(title: "Time", iconSystemName: "clock.fill", color: Color.cyan)
                }
            }
            
            Section {
                if hypedEvent.image() == nil {
                    HStack {
                        FormLabelView(title: "Image", iconSystemName: "camera", color: Color.purple)
                        Spacer()
                        
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Text("Pick Image")
                        }
                    }
                } else {
                    HStack {
                        FormLabelView(title: "Image", iconSystemName: "camera", color: Color.purple)
                        Spacer()
                        
                        Button(action: {
                            hypedEvent.imageData = nil
                        }) {
                            Text("Remove Image")
                                .foregroundColor(.red)
                        }
                    }
                    hypedEvent.image()!
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(imageData: $hypedEvent.imageData)
            }
            
            Section {
                
                ColorPicker(selection: $hypedEvent.color) {
                    FormLabelView(title: "Color", iconSystemName: "eyedropper", color: Color.green)
                }
            }
            Section {
                FormLabelView(title: "URL", iconSystemName: "link", color: Color.orange)
                
                TextField("Website, ex. google.com", text: $hypedEvent.title)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }
        }
    }
}

struct CreateHypedEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
