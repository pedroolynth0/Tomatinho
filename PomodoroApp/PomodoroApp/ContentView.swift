//
//  ContentView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Hello, world!")
                .font(.custom("ZillaSlab-Regular", size: 26))
        }
        

        .padding()
    }
}

#Preview {
    ContentView()
}
