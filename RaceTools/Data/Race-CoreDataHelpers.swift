//
//  Race-CoreDataHelpers.swift
//  RaceTools
//
//  Created by Jake Smith on 5/4/22.
//

import Foundation
import SwiftUI
import SwiftSoup

extension Race {

    var raceName: String {
        name ?? "New Race"
    }
    
    var raceDate: Date {
        date ?? Date()
    }
    
    var raceDateString: String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df.string(from: raceDate)
    }
    
    var daysAway: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour], from: Date(), to: raceDate)
        return components.day! + 1
    }
    
    var hoursAway: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date(), to: raceDate)
        return components.hour ?? 0
    }
    
    var raceURL: String {
        url ?? ""
    }
    
    var raceDistance: String {
        distance ?? ""
    }
    
    var raceDistanceUnit: String {
        distanceUnit ?? ""
    }
    
    static var example: Race {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext
        
        let race = Race(context: viewContext)
        race.name = "Santa Sprint 5k"
        race.completed = false
        race.date = Calendar.current.date(from: DateComponents(year: 2022, month: 6, day: 23))
        race.distance = "5"
        race.distanceUnit = "kilometer"
        return race
    }
}
