//
//  AddRaceView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/1/22.
//

import SwiftUI

struct AddRaceView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var raceDate = Date.now
    
    var body: some View {
        NavigationView {
            Form {
                Section("Race Info") {
                    TextField("Race Name", text: $name)
                    DatePicker("Race Date", selection: $raceDate, displayedComponents: .date)
                    // distance input
                }
                Section {
                    Button("add race") {
                        let race = Race(context: moc)
                        race.name = name
                        race.date = raceDate
                        dataController.save()
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
}

struct AddRaceView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        NavigationView {
            AddRaceView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
