//
//  ZoomInAndOutView.swift
//  LocalBuzz
//
//  Created by Shweta Ambarkhane on 13/10/24.
//

import SwiftUI

struct ZoomInAndOutView: View {
    
    var body: some View {
        // Zoom buttons overlay
        VStack {
            Spacer()
            HStack {
                Spacer() // Push buttons to the right
                VStack {
                    Button(action: {
                        zoomIn()
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        zoomOut()
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom)
            }
        }
    }
    
    // Zoom In Function
    func zoomIn() {
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
    }

    // Zoom Out Function
    func zoomOut() {
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
    }
}
