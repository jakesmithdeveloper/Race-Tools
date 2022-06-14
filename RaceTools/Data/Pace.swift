//
//  Pace.swift
//  RaceTools
//
//  Created by Jake Smith on 6/8/22.
//

import Foundation

struct Pace {
    let seconds: Int
    let minutes: Int
    let hours: Int
    
    init(paceSeconds: Double) {
        self.hours = Int(((paceSeconds.truncatingRemainder(dividingBy: 86400) ) / 3600).rounded(.down))
        self.minutes = Int(((paceSeconds.truncatingRemainder(dividingBy: 3600)) / 60))
        self.seconds = Int(((paceSeconds.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60)).rounded())
    }
}
