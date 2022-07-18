//
//  AddRaceView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/1/22.
//

import SwiftSoup
import SwiftUI

struct AddRaceView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var raceDate = Date.now
    
    @State var distance = "0"
    @State var selectedDistanceUnit = "mile"
    @State var url = ""
    
    let distanceUnits = ["mile", "kilometer"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Race Info") {
                    TextField("Race Name", text: $name)
                    DatePicker("Race Date", selection: $raceDate, displayedComponents: .date)
                    TextField("race url", text: $url)
                }
                
                Section("Distance") {
                    TextField("race distance", text: $distance)
                    Picker("Distance type", selection: $selectedDistanceUnit) {
                        ForEach(distanceUnits, id: \.self) {
                            Text("\($0)s")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Button("add race") {
                        addRace()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add New Race")
            .toolbar {
                Button("cancel", role: .cancel) { dismiss() }
            }
        }
    }
    
    func addRace() {
        let race = Race(context: moc)
        
        // User input fields
        race.name = name
        race.date = raceDate
        race.distance = distance
        race.distanceUnit = selectedDistanceUnit
        
        // handle URL stuff
        race.url = url
        race.imgUrl = fetchImageURL(urlStr: url)
        // sace the new race instance to Core Data
        dataController.save()
    }
    
    func fetchImageURL(urlStr: String)  -> String? {
        do {
            if let url = URL(string: urlStr) {
                let html = try String(contentsOf: url)
                let doc = try SwiftSoup.parse(html)
                let head = doc.head()
                let meta = try head?.select("meta[property=og:image]").first()
                return try meta?.attr("content") ?? ""
                
            }
        } catch {
            print("error when parsing URL")
        }
        return nil
    }
}

struct AddRaceView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        AddRaceView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
