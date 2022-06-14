//
//  CalendarView.swift
//  RaceTools
//
//  Created by Jacob Smith on 6/13/22.
//

import SwiftUI

struct CalendarView: View {
    
    let days = Calendar.current.shortWeekdaySymbols
    let monthString = Calendar.current.monthSymbols[Calendar.current.component(.month, from: Date.now)]
    
    let columns = Array(repeating: GridItem(.adaptive(minimum: 30)), count: 7)
    
    var body: some View {
        VStack {
            Text(monthString)
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) {
                    Text($0)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach((1...31), id: \.self) {
                    Text("\($0)")
                        .frame(width: 32, height: 32)
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
