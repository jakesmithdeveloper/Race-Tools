//
//  Race-CoreDataHelpers.swift
//  RaceTools
//
//  Created by Jake Smith on 5/4/22.
//

import Foundation

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

    var raceGoalFinish: String {
        goalFinish ?? ""
    }
    
    var raceGoalPace: String {
        goalPace ?? ""
    }
    
    static var example: Race {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let race = Race(context: viewContext)
        race.name = "Example Race"
        race.completed = false
        race.date = Date.now
        return race
    }
}
