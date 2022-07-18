//
//  DataController.swift
//  RaceTools
//
//  Created by Jake Smith on 5/1/22.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        let calendar = Calendar.current
        
        let dates = [calendar.date(from: DateComponents(year: 2022, month: 7, day: 4)), calendar.date(from: DateComponents(year: 2022, month: 7, day: 16)), calendar.date(from: DateComponents(year: 2022, month: 7, day: 30)), calendar.date(from: DateComponents(year: 2022, month: 8, day: 13))]
        let names = ["16th Dewey Beach Liquors 5k at Northbeach", "21st Santa Sprint 5k at Northbeach", "20th Penn State Day 5k at Northbeach", "ettie James Fest 5k at Northbeach"]
        
        for i in 0...3 {
            let race = Race(context: viewContext)
            race.name = names[i]
            race.completed = false
            race.date = dates[i]
        }
        
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }


    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Race.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
    static var preview: DataController {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating previews: \(error.localizedDescription)")
        }
        
        return dataController
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
}
