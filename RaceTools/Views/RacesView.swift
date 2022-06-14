//
//  RacesView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/1/22.
//

import SwiftUI

struct RaceSection: Identifiable {
    let name: String
    let races: [Race]
    let id = UUID()
}

struct RacesView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingAddRaceView = false
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date)
    ]) var races: FetchedResults<Race>
    
    var displayedRaces: [Race] {
        Array(races).filter { race in
            race.raceDate > Date.now
        }
    }
    
    var pastRaces: [Race] {
        Array(races).filter { race in
            race.raceDate < Date.now
        }
    }
    
    var sections: [RaceSection] {
        if races.isEmpty != true {
            return [RaceSection(name: "Upcomming Races", races: Array(displayedRaces)), RaceSection(name: "Past Races", races: pastRaces)]
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sections) { section in
                    Section("\(section.name)") {
                        ForEach(section.races, id: \.self) { race in
                            RaceRow(race: race)
                        }
                        .onDelete { offsets in
                            for offset in offsets {
                                let race = races[offset]
                                dataController.delete(race)
                            }
                            
                            dataController.save()
                        }
                    }
                }
            }
            .navigationTitle("Upcomming Races")
            .toolbar {
                Button {
                    // add a race
                    withAnimation {
                        showingAddRaceView = true
                    }
                } label: {
                    Label("add", systemImage: "plus")
                }

            }
            .sheet(isPresented: $showingAddRaceView)  {
                AddRaceView()
            }
        }
    }
    
}

struct RacesView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
            RacesView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
    }
}
