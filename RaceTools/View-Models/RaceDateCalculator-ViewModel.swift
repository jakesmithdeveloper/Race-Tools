//
//  RaceDateCalculator-ViewModel.swift
//  RaceTools
//
//  Created by Jake Smith on 5/9/22.
//

import Foundation

enum DateCalculation: CaseIterable {
    case raceDate, startDate, trainingBlockLength
    
    var description: String {
        switch self {
        case .raceDate:
            return "Race Date"
        case .startDate:
            return "Start Date"
        case .trainingBlockLength:
            return "Training Block Length"
        }
    }
    
    var explanation: String {
        switch self {
        case .raceDate:
            return "Find out when your race date should be given your start date and how many weeks you'd like to train"
        case .startDate:
            return "Find out when you should start training with your Race date and training block length"
        case .trainingBlockLength:
            return "Calculate how many weeks you have to train given your race date and start date"
        }
    }
}

extension RaceDateCalculatorView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var raceDate: Date = Date.now
        @Published var startDate: Date = Date.now
        @Published var trainingBlockLength: String = ""
        @Published var calcMode: DateCalculation = .startDate
        
        var trainingBlockWeeks: Int {
            Int(trainingBlockLength) ?? 0
        }
        
        var result: String {
            let df = DateFormatter()
            df.timeStyle = .none
            df.dateStyle = .short
            
            switch self.calcMode {
            case .raceDate:
                return "Race Date: \(df.string(from: Calendar.current.date(byAdding: .weekOfYear, value: trainingBlockWeeks, to: startDate) ?? Date.now))"
            case .startDate:
                return "start date: \(df.string(from: Calendar.current.date(byAdding: .weekOfYear, value: (trainingBlockWeeks * -1), to: raceDate) ?? Date.now))"
            case .trainingBlockLength:
                
                let resultComponents = Calendar.current.dateComponents([.weekOfYear, .day], from: startDate, to: raceDate)
                let weeks = resultComponents.weekOfYear!
                let days = resultComponents.day!
                
                return "\(weeks) \(weeks == 1 ? "week" : "weeks") \(days) \(days == 1 ? "day" : "days")"
            }
        }
    }
}
