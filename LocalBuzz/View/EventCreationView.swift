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
    @State var eventToEdit: Event?
    @State var indexOfEvent: Int = 0
    @State var isEditing: Bool
    
    private var eventToEditValue: Event?

    @State private var title = ""
    @State private var description = ""
    @State private var time = Date()
    @State private var latitude: String = "37.7749"
    @State private var longitude: String = "-122.4194"
    
    init(events: Binding<[Event]>) {
        _events = events
        self.isEditing = false
    }
    
    init(events: Binding<[Event]>, indexOfEvent: Int) {
        _events = events
        self.indexOfEvent = indexOfEvent
        self.isEditing = true
        self.eventToEditValue = self.events[indexOfEvent]
    }

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

                Button(action: isEditing ? editEvent : createEvent) {
                    Text(isEditing ? "Save Changes" :"Create Event")
                }
            }
            .onAppear {
                eventToEdit = eventToEditValue
                if let eventToEdit = eventToEditValue {
                    title = eventToEdit.title
                    description = eventToEdit.description
                    time = eventToEdit.time
                    latitude = "\(eventToEdit.location.latitude)"
                    longitude = "\(eventToEdit.location.longitude)"
                }
            }
            .navigationTitle(isEditing ? "Edit Event" : "New Event")
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
    
    func editEvent() {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        let newEvent = Event(title: title, description: description, location: CLLocationCoordinate2D(latitude: lat, longitude: lon), time: time)
        events[indexOfEvent] = newEvent
        presentationMode.wrappedValue.dismiss()
    }
}
