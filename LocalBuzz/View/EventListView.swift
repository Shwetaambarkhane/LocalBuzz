//
//  EventListView.swift
//  LocalBuzz
//
//  Created by Shweta Ambarkhane on 13/10/24.
//

import SwiftUI
import MapKit

struct EventListView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var events: [Event] = [
        Event(title: "Coffee Meetup", description: "Grab coffee with locals", location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), time: Date()),
        Event(title: "Street Art Tour", description: "Explore local street art", location: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094), time: Date().addingTimeInterval(3600)),
    ]

    @State private var showEventCreation = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    MapView(region: $region, events: events)
                        .frame(height: 300)
                    
                    ZoomInAndOutView()
                }
                
                List(events) { event in
                    VStack(alignment: .leading) {
                        Text(event.title).font(.headline)
                        Text(event.description).font(.subheadline)
                        Text("Happening at \(event.time, formatter: eventFormatter)")
                            .font(.caption)
                    }
                }
                .navigationTitle("LocalBuzz")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            showEventCreation.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showEventCreation) {
            EventCreationView(events: $events)
        }
    }
}

let eventFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
