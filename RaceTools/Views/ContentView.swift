//
//  ContentView.swift
//  RaceTools
//
//  Created by Jake Smith on 4/29/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RacesView()
                .tabItem {
                    Label("Races", systemImage: "flag.circle")
                }
            
            PaceCalculatorView()
                .tabItem {
                    Label("Pace", systemImage: "stopwatch")
                }
            
            RaceDateCalculatorView()
                .tabItem {
                    Label("Date Calculator", systemImage: "calendar")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
