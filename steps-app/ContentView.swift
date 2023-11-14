//
//  ContentView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

struct ContentView: View {
    // add a counter property
    @State private var counter = 0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // Display the counter
            Text("Counter: \(counter)")
            
            // Add a button that increments the counter
            Button("Tap me!") {
                counter += 1
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
