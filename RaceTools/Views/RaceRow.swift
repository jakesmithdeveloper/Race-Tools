//
//  RaceRow.swift
//  RaceTools
//
//  Created by Jake Smith on 6/8/22.
//

import SwiftUI

struct RaceRow: View {
    
    let race: Race
    
    var body: some View {
        NavigationLink(destination: RaceView(race: race)) {
            HStack {
                Text(race.raceName)
                if race.daysAway > 0 {
                    Text("(\(race.daysAway) day\(race.daysAway == 1 ? "" : "s"))")                    
                }
            }
            .lineLimit(1)
        }
    }
}

struct RaceRow_Previews: PreviewProvider {
    static var previews: some View {
        RaceRow(race: Race.example)
    }
}
