//
//  RaceView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/4/22.
//

import SwiftUI

struct RaceView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.editMode) private var editMode
    
    let race: Race

    @State private var name: String
    @State private var date: Date
    @State private var completed: Bool
    @State private var url: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: race.imgUrl ?? "")) { img in
                img
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray
            }

            Form {
                Section("Race Info") {
                    HStack {
                        Text("Name: ")
                        if editMode?.wrappedValue.isEditing == true {
                            TextField("name", text: $name)
                        } else {
                            Text(name)
                                .foregroundColor(.secondary)
                        }
                    }
                    if editMode?.wrappedValue.isEditing == true {
                        DatePicker("race date ", selection: $date, displayedComponents: [.date])
                    } else {
                        Text("Race Date: \(race.raceDateString)")
                    }
                    HStack {
                        Text("race url: ")
                        if editMode?.wrappedValue.isEditing == true {
                            TextField("url", text: $url)
                        } else {
                            Text(url)
                                .foregroundColor(.secondary)
                        }
                    }
                    if editMode?.wrappedValue.isEditing == true {
                        Toggle("completed", isOn: $completed)
                    }
                    if editMode?.wrappedValue.isEditing == true {
                        Button("Delete Race", role: .destructive) {
                            //dataController.delete(race)
                        }
                        .onTapGesture {
                            dataController.delete(race)
                        }
                    }
                }
            }
        }
        .navigationTitle("\(name) (\(race.daysAway) days)")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: editMode?.wrappedValue, perform: { newValue in
            if newValue?.isEditing != true {
                update()
            }
        })
        .toolbar { EditButton() }
    }
    
    func update() {
        race.objectWillChange.send()
        race.name = name
        race.date = date
        race.completed = completed
        race.url = url
    }
    
    init(race: Race) {
        self.race = race
        _name = State(wrappedValue: race.raceName)
        _date = State(wrappedValue: race.raceDate)
        _completed = State(wrappedValue: race.completed)
        _url = State(wrappedValue: race.raceURL)
    }
}

struct RaceView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        NavigationView {
            RaceView(race: Race.example)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
