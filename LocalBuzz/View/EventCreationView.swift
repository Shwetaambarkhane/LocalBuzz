//
//  EventCreationView.swift
//  LocalBuzz
//
//  Created by Shweta Ambarkhane on 13/10/24.
//

import SwiftUI
import MapKit

struct EventCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var events: [Event]

    @State private var title = ""
    @State private var description = ""
    @State private var time = Date()
    @State private var latitude: String = "37.7749"
    @State private var longitude: String = "-122.4194"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Info")) {
                    TextField("Event Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Location")) {
                    TextField("Latitude", text: $latitude)
                    TextField("Longitude", text: $longitude)
                }

                Button(action: createEvent) {
                    Text("Create Event")
                }
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    func createEvent() {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        let newEvent = Event(title: title, description: description, location: CLLocationCoordinate2D(latitude: lat, longitude: lon), time: time)
        events.append(newEvent)
        presentationMode.wrappedValue.dismiss()
    }
}
