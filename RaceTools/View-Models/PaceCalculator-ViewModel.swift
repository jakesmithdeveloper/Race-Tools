//
//  PaceCalculator-ViewModel.swift
//  RaceTools
//
//  Created by Jake Smith on 5/9/22.
//

import Foundation

enum CalcType: CaseIterable  {
    case pace, finish
    
    var description: String {
        switch self {
        case .pace:
            return "Goal Pace"
        case .finish:
            return "Finish Time"
        }
    }
}

extension PaceCalculatorView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var distanceInput = ""
        @Published var inputDistanceType = "mile"
        @Published var outputDistanceType = "mile"
        @Published var calculationType: CalcType = .pace
        
        @Published var hoursInput = ""
        @Published var minutesInput = ""
        @Published var secondsInput = ""
        
        let distanceTypes = ["mile", "kilometer"]
        
        var result: String {
            if calculationType == .pace {
                // calculate goal pace
                guard distance > 0.0 else { return "" }
                
                let totalSeconds = seconds + (minutes * 60) + (hours * 3600)
                
                let conversionDistance = (inputDistanceType == outputDistanceType ? distance : getConversion())
                
                let goalPaceSeconds = Double(totalSeconds) / conversionDistance
                
                let goalPace = Pace(paceSeconds: goalPaceSeconds)
                
                return displayTime(hours: goalPace.hours, minutes: goalPace.minutes, seconds: goalPace.seconds)
            } else {
                // calculate total time
                guard distance > 0.0 else { return "" }
                
                let totalPaceSeconds = seconds + (minutes * 60) + (hours * 3600)
                
                let conversionDistance = (inputDistanceType == outputDistanceType ? distance : getConversion())
                
                let totalSeconds = Double(totalPaceSeconds) * conversionDistance
                
                let finishTime = Pace(paceSeconds: totalSeconds)
                
                return displayTime(hours: finishTime.hours, minutes: finishTime.minutes, seconds: finishTime.seconds)
            }
        
        }
        
        func displayTime(hours: Int, minutes: Int, seconds: Int) -> String {
            var hoursString = String(hours)
            var minutesString = String(minutes)
            var secondsString = String(seconds)
            
            // pretty hours
            if hours == 0 {
                hoursString = ""
            } else {
                hoursString = "\(hoursString):"
            }
            
            // pretty minutes
            if hours > 0 {
                minutesString = minutes < 10 ? "0\(minutesString)" : "\(minutesString):"
            } else if minutes == 0 {
                minutesString = ""
            } else {
                minutesString = "\(minutesString):"
            }
            
            // pretty seconds
            if minutes > 0 {
                secondsString = seconds < 10 ? "0\(secondsString)" : secondsString
            } else if seconds == 0 {
                secondsString = ""
            }
            
            return "\(hoursString)\(minutesString)\(secondsString)"
        }
        
        func getConversion() -> Double {
            if inputDistanceType == "mile" {
                // output distance type must be km
                return milesToKilometers(distance)
            } else {
                // output distance type must be miles
                return kilometersToMiles(distance)
            }
        }
        
        func milesToKilometers(_ miles: Double) -> Double {
            return miles * 1.60934
        }
        
        func kilometersToMiles(_ kms: Double) -> Double {
            return kms / 1.60934
        }
        
        var hours: Int {
            return Int(hoursInput) ?? 0
        }
        
        var minutes: Int {
            return Int(minutesInput) ?? 0
        }
        
        var seconds: Int {
            return Int(secondsInput) ?? 0
        }
        
        var distance: Double {
            Double(distanceInput) ?? 0.0
        }
        
        func clearInputs() {
            hoursInput = ""
            minutesInput = ""
            secondsInput = ""
            distanceInput = ""
        }
        
        func validate() {
            validateHours()
            validateMinutes()
            validateSeconds()
        }
        
        func validateHours() {
            hoursInput = String(hoursInput.prefix(2))
            if hours == 0 {
                hoursInput = ""
            }
        }
        
        func validateMinutes() {
            minutesInput = String(minutesInput.prefix(2))
            if hours > 0 {
                if minutes == 0 {
                    minutesInput = "00"
                } else if minutes < 10 {
                    minutesInput = "0\(String(Int(minutesInput) ?? 0))"
                }
            }
        }
        
        func validateSeconds() {
            secondsInput = String(secondsInput.prefix(2))
            if minutes > 0 {
                if seconds == 0 {
                    secondsInput = "00"
                } else if seconds < 10 {
                    secondsInput = "0\(String(Int(secondsInput) ?? 0))"
                }
            }
        }
    }
}
